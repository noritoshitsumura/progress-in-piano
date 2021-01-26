class CreatePractices < ActiveRecord::Migration[5.2]
  def change
    create_table :practices do |t|
      t.integer :time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
