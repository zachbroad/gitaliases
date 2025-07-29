class CreateVotes < ActiveRecord::Migration[8.0]
  def change
    create_table :votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :alias, null: false, foreign_key: true
      t.integer :vote_type, null: false

      t.timestamps
    end

    add_index :votes, [ :user_id, :alias_id ]
  end
end
