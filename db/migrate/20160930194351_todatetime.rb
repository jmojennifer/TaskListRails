class Todatetime < ActiveRecord::Migration
  def change
    change_column(:tasks, :completion_date, :datetime)
  end
end
