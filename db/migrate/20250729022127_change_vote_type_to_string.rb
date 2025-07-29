class ChangeVoteTypeToString < ActiveRecord::Migration[8.0]
  def change
    change_column :votes, :vote_type, :string
  end
end
