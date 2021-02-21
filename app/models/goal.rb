class Goal < ApplicationRecord
  validates :name, presence: true

  belongs_to :user
  has_many :scorings, dependent: :destroy
  has_many :groups, through: :scorings
  has_many :goalings, dependent: :destroy
  has_many :competitions, through: :goalings

  scope :sum_goals, -> { sum(:amount) }

  def parent_group
    group_id = Scoring.where(goal_id: self.id).first[:group_id]
    Group.find(group_id)
  end

  def group_absent?
    Group.all.empty?
  end

  def competition_absent?
    Competition.all.empty?
  end
end
