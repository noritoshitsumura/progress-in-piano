class ChangeDatatypeTimeOfPractices < ActiveRecord::Migration[5.2]
  def change
    change_column :practices, :time, :integer
  end
end
