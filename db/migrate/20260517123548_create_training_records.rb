class CreateTrainingRecords < ActiveRecord::Migration[7.2]
  def change
    create_table :training_records do |t|
      t.references :user, null: false, foreign_key: true
      t.date :trained_on, null: false
      t.text :memo

      t.timestamps
    end

    add_index :training_records, [:user_id, :trained_on], unique: true
  end
end
