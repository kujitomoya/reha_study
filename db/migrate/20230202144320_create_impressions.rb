class CreateImpressions < ActiveRecord::Migration[6.1]
  def change
    create_table :impressions do |t|

      t.integer :customer_id, null: false
      t.integer :fields_id, null: false
      t.string :name, null: false
      t.string :impression_title, null: false
      t.text :impression_text, null: false
      t.timestamps
    end
  end
end
