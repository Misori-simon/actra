class Competition < ApplicationRecord
  belongs_to :user
  has_many :goalings, dependent: :destroy
  has_many :goals, through: :goalings
  has_one_attached :image

  before_save :downcase_fields
  before_save :name_exists?

  def downcase_fields
    name.downcase!
  end

  def name_exists?
    return if Competition.where(name: name).empty?

    errors.add(:base, 'Competition already exists')
    throw(:abort)
  end
end
