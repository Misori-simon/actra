class Goal < ApplicationRecord
  validates :name, presence: true

  belongs_to :user
  has_many :scorings, dependent: :destroy
  has_many :groups, through: :scorings

  scope :sum_goals, -> { sum(:amount) }
end
