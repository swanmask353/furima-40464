class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :user,              null: false, foreign_key: true
      t.string :title,                 null: false, default: ""
      t.text :description,             null: false, default: ""
      t.integer :price,                precision: 10, scale: 2, default: 0.0
      t.integer :category_id,          null: false 
      t.integer :condition_id,         null: false
      t.integer :shipping_cost_id,     null: false
      t.integer :prefecture_id,        null: false
      t.integer :shipping_duration_id, null: false
      t.timestamps
    end
  end
end
