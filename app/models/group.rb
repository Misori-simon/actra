class Group < ApplicationRecord
  validates :name, presence: true, length: { in: 2..30 }

  belongs_to :user
end
