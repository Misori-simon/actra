class Group < ApplicationRecord
  validates :name, presence: true, length: { in: 2..30 }

  belongs_to :user
  has_many :scorings, dependent: :destroy
  has_many :goals, through: :scorings

  def create_scoring
    scorings.new(goal: @goal)
    # render :edit unless scoring.save
  end
end
