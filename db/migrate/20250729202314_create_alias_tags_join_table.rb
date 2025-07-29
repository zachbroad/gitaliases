class CreateAliasTagsJoinTable < ActiveRecord::Migration[8.0]
  def change
    create_join_table :aliases, :tags do |t|
      t.index [:alias_id, :tag_id], unique: true
      t.index [:tag_id, :alias_id]
    end
  end
end
