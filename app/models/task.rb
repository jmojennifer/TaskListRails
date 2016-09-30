class Task < ActiveRecord::Base

  def mark_complete
    self.completion_status = "Completed"
    self.completion_date = DateTime.current
  end
end
