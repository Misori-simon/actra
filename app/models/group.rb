class Group < ApplicationRecord
  validates :name, presence: true, length: { in: 2..30 }

  belongs_to :user
  has_many :scorings, dependent: :destroy
  has_many :goals, through: :scorings
  has_one_attached :image

  before_save :downcase_fields
  before_save :name_exists?

  def downcase_fields
    name.downcase!
  end

  def name_exists?
    return if Group.where(name: name).empty?

    errors.add(:base, 'Style already exists')
    throw(:abort)
  end
end
