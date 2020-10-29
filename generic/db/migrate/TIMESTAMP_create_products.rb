class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string  :name,     null: false
      t.string  :title,    null: false
      t.string  :sku,      null: false
      t.decimal :price,    null: false, default: 0
      t.text    :description
      t.integer :status,   null: false, default: 0, limit: 1  # default: active

      t.timestamps
    end
    add_index :products, :name,  unique: true
    add_index :products, :title, unique: true
    add_index :products, :sku,   unique: true
  end
end
