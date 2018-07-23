class CreateJoinTableLearningObjectivesYears < ActiveRecord::Migration[5.2]
  def change
    create_join_table :learning_objectives, :years do |t|
      # t.index [:learning_objective_id, :year_id]
      # t.index [:year_id, :learning_objective_id]
    end
  end
end
