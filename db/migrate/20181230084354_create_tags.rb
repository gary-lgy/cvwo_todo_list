class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :name
      t.timestamps
    end

    create_table :tags_tasks, id: false do |t|
      t.references :task, index: true
      t.references :tag, index: true
    end
  end
end
