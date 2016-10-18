class TaskOwner < ActiveRecord::Migration
  def change
    add_column(:tasks, :owner_uid, :integer)
  end
end
