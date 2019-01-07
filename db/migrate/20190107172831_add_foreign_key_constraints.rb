class AddForeignKeyConstraints < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :tags_tasks, :tasks
    add_foreign_key :tags_tasks, :tags
  end
end
