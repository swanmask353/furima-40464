class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.reference :user,               null: false, foreign_key: true
      t.string :title,                 null: false, default: ""
      t.text :description,             null: false, default: ""
      t.integer :price,                null: false, default: ""
      t.integer :category_id,          null: false, default: ""
      t.integer :condition_id,         null: false
      t.integer :shippong_cost_id,     null: false, default: ""
      t.integer :prefecture_id,        null: false, default: nil
      t.integer :shipping_duration_id, null: false, default: nil
      t.timestamps
    end
  end
end
