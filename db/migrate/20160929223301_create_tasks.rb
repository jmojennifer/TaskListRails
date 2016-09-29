class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.name null: false
      t.description
      t.completion_status null:false
      t.completion_date
      t.timestamps null: false
    end
  end
end
