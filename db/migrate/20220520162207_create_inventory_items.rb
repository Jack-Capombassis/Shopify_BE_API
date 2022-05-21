class CreateInventoryItems < ActiveRecord::Migration[7.0]
  def change
    create_table :inventory_items do |t|
      t.string "cost", null: false 
      t.string "country_code_of_origin"
      t.string "province_code_of_origin"
      t.string "sku", null: false
      t.boolean "tracked", default: false
      t.boolean "requires_shipping" default: false
      t.timestamps
    end
  end
end
