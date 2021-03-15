class Goal < ApplicationRecord
  validates :name, presence: true
  validates :amount, presence: true

  belongs_to :user
  has_many :scorings, dependent: :destroy
  has_many :groups, through: :scorings
  has_many :goalings, dependent: :destroy
  has_many :competitions, through: :goalings

  scope :sum_goals, -> { sum(:amount) }
  scope :latest, -> { order('created_at DESC') }

  def parent_group
    group_id = Scoring.where(goal_id: id).first[:group_id]
    Group.find(group_id)
  end
end
