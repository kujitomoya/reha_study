class RenameImpressionTitleImpressionTextColumnToImpressions < ActiveRecord::Migration[6.1]
  def change
    rename_column :impressions, :impression_title, :title
    rename_column :impressions, :impression_text, :text
  end
end
