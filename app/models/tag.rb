class Tag < ApplicationRecord
  has_and_belongs_to_many :tasks

  # user_id cannot be blank
  validates :user_id, presence: true

  # name must be unique for each user_id
  validates :name, presence: true, uniqueness: { scope: :user_id }

  # override ActiveRecord::Base#to_param such that automatically
  # generated urls will use name as identifier (instead of id)
  def to_param
    name
  end

end
