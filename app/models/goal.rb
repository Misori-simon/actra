class Goal < ApplicationRecord
  validates :name, presence: true

  belongs_to :user
  has_many :scorings, dependent: :destroy
  has_many :groups, through: :scorings
  has_many :goalings, dependent: :destroy
  has_many :competitions, through: :goalings

  scope :sum_goals, -> { sum(:amount) }
end
