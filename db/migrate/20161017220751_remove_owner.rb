class RemoveOwner < ActiveRecord::Migration
  def change
    remove_column(:tasks, :owner)
  end
end
