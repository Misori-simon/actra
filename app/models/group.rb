class Group < ApplicationRecord
  validates :name, presence: true, length: { in: 2..30 }

  belongs_to :user
  has_many :scorings, dependent: :destroy
  has_many :goals, through: :scorings
  has_one_attached :image

  before_save :downcase_fields
  before_create :name_exists?

  scope :groups_goals_count, lambda {
    joins(:goals).select(
      'groups.*, SUM(goals.amount) AS goals_count'
    ).group('groups.id')
  }

  def downcase_fields
    name.downcase!
  end

  def name_exists?
    return if current_user.groups.where(name: name).empty?

    errors.add(:base, 'Style already exists')
    throw(:abort)
  end

  def current_user
    User.find(user_id)
  end
end
