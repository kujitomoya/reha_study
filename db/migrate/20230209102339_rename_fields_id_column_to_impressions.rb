class RenameFieldsIdColumnToImpressions < ActiveRecord::Migration[6.1]
  def change
    rename_column :impressions, :fields_id, :field_id
  end
end
