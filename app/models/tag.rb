class Tag < ApplicationRecord
  has_and_belongs_to_many :tasks
  validates :name, presence: true, uniqueness: { scope: :user_id }
end
