class Task < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true
  validates :completion_status, presence: true

  def mark_complete
    self.completion_status = "Completed"
    self.completion_date = DateTime.current
  end
end
