class AddUserToAliases < ActiveRecord::Migration[8.0]
  def change
    add_reference :aliases, :user, null: true, foreign_key: true
  end
end
