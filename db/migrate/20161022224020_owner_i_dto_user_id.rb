class OwnerIDtoUserId < ActiveRecord::Migration
  def change
    rename_column(:tasks, :owner_id, :user_id)
  end
end
