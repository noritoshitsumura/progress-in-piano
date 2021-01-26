class ChangeDatatypeTimeOfPractices < ActiveRecord::Migration[5.2]
  def change
    change_column :practices, :time, 'integer USING CAST(column_name AS integer)'
  end
end
