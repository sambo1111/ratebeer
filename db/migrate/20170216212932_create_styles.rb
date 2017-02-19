class CreateStyles < ActiveRecord::Migration
  def change

    remove_column :beers, :style, :string

    create_table :styles do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end

    add_column :beers, :style_id, :integer

  end
end
