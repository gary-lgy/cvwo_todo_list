class Task < ApplicationRecord
  has_and_belongs_to_many :tags

  # task title and user_id cannot be blank
  validates :title, :user_id, presence: true

  # scopes for retrieving different categories of tasks
  scope :completed, -> { where completed: true }
  scope :ongoing, -> { where completed: false }

  # toggle between completed and imcomplete
  # return the final state of the task
  def toggle_completed
    update completed: !completed
    completed
  end

  # save a newly created task
  def save_new
    self.completed = false
    save
  end

  # helper methods to query the status of a task
  def completed?
    completed
  end

  def urgent?
    !completed && !deadline.nil? &&
      deadline < 1.day.from_now && deadline > Time.now
  end

  def overdue?
    !completed && !deadline.nil? &&
      deadline < Time.now
  end

  def status
    if completed
      'completed'
    elsif deadline.nil? || deadline > 1.day.from_now
      'normal'
    elsif deadline < Time.now
      'overdue'
    else
      'urgent'
    end
  end

end
