class AllowNulls < ActiveRecord::Migration[8.0]
  def change
    change_column_null :aliases, :name, true
    change_column_null :aliases, :description, true
    change_column_null :aliases, :code, true
  end
end
