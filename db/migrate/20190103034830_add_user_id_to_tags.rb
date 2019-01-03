require_relative '20181231093047_add_unique_index_on_tag_names.rb'

class AddUserIdToTags < ActiveRecord::Migration[5.2]
  def change
    revert AddUniqueIndexOnTagNames
    add_column :tags, :user_id, :string
    add_index :tags, [:user_id, :name], unique: true
  end
end
