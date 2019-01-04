class Tag < ApplicationRecord
  has_and_belongs_to_many :tasks
  validates :name, presence: true, uniqueness: { scope: :user_id }

  # override ActiveRecord::Base#to_param such that automatically
  # generated urls will use name as identifier (instead of id)
  def to_param
    name
  end

end
