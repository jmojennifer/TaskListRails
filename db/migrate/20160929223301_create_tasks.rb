class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.string :description
      t.string :completion_status, null: false
      t.date :completion_date
      t.timestamps null: false
    end
  end
end
