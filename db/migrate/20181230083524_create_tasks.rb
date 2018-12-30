class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :user_id, index: true
      t.string :title
      t.string :description
      t.datetime :deadline
      t.boolean :completed
      t.timestamps
    end
  end
end
