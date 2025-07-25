class Alias < ActiveRecord::Migration[8.0]
  def change
    change_column_null :aliases, :name, false
    change_column_null :aliases, :description, false
    change_column_null :aliases, :code, false
  end
end
