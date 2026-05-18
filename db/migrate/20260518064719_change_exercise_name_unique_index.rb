class ChangeExerciseNameUniqueIndex < ActiveRecord::Migration[7.2]
  def change
    remove_index :exercises, column: [:user_id, :name]

    add_index :exercises,
              [:user_id, :name],
              unique: true,
              where: "active = true",
              name: "index_active_exercises_on_user_id_and_name"
  end
end
