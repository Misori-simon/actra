class User < ApplicationRecord
  validates :name, presence: true, length: { in: 6..20 }

  has_many :groups, dependent: :destroy
end
