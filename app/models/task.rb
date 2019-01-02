class Task < ApplicationRecord
  has_and_belongs_to_many :tags

  # task title cannot be blank
  validates :title, presence: true

  # scopes for retrieving different categories of tasks
  scope :archived, -> { where completed: true }
  scope :ongoing, -> { where completed: false }

  # helper methods to query the status of the task
  def archived?
    completed
  end

  def ongoing?
    not archived?
  end

  def normal?
    ongoing? && (deadline.nil? || deadline > 1.day.from_now)
  end

  def urgent?
    ongoing? && !deadline.nil? &&
      deadline < 1.day.from_now && deadline > Time.now
  end

  def overdue?
    ongoing? && !deadline.nil? &&
      deadline < Time.now
  end

  def status
    if archived?
      'archived'
    elsif urgent?
      'urgent'
    elsif overdue?
      'overdue'
    else
      'normal'
    end
  end

  # toggle between completed and uncompleted
  def toggle_completed
    update completed: !completed
  end
end
