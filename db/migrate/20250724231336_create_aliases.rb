class CreateAliases < ActiveRecord::Migration[8.0]
  def change
    create_table :aliases do |t|
      t.string :name
      t.string :description
      t.string :code

      t.timestamps
    end
  end
end
