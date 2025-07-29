class AddIpAddressToVotes < ActiveRecord::Migration[8.0]
  def change
    add_column :votes, :ip_address, :string
    add_index :votes, [ :ip_address, :alias_id ], unique: true, where: "user_id IS NULL"
    change_column_null :votes, :user_id, true
  end
end
