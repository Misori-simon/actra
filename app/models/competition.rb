class Competition < ApplicationRecord
  belongs_to :user
  has_many :goalings, dependent: :destroy
  has_many :goals, through: :goalings
  has_one_attached :image
end
