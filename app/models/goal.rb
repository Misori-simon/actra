class Goal < ApplicationRecord
  validates :name, presence: true

  belongs_to :user
  has_many :scorings
  has_many :groups, through: :scorings
end
