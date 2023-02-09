class RenameFieldNameColumnToFields < ActiveRecord::Migration[6.1]
  def change
    rename_column :fields, :field_name, :name
  end
end
