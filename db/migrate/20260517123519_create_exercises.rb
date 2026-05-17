class CreateExercises < ActiveRecord::Migration[7.2]
  def change
    create_table :exercises do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :body_part, null: false
      t.text :memo
      t.boolean :active, null: false, default: true

      t.timestamps
    end

    add_index :exercises, [:user_id, :name], unique: true
  end
end
