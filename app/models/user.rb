class User < ApplicationRecord
  validates :name, presence: true, length: { in: 6..20 }

  has_many :groups, dependent: :destroy
  has_many :goals, dependent: :destroy
  has_many :competitions, dependent: :destroy
  has_one_attached :image

  before_save :downcase_fields
  before_create :name_exists?

  def downcase_fields
    name.downcase!
  end

  def name_exists?
    return if User.where(name: name).empty?

    errors.add(:base, 'Name is taken')
    throw(:abort)
  end
end
