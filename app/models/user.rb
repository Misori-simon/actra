class User < ApplicationRecord
  validates :name, presence: true, length: { in: 6..20 }

  has_many :groups, dependent: :destroy
  has_many :goals, dependent: :destroy
  has_one_attached :image
end
