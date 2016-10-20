class OwnerUiDtoOwnerId < ActiveRecord::Migration
  def change
    rename_column(:tasks, :owner_uid, :owner_id)
  end
end
