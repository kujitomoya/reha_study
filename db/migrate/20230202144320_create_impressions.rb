class CreateImpressions < ActiveRecord::Migration[6.1]
  def change
    create_table :impressions do |t|

      t.integer :customer_id, null: false
      t.integer :field_id
      t.string :name, null: false
      t.string :title, null: false
      t.text :text, null: false
      t.timestamps
    end
  end
end
