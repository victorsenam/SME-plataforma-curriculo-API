class RemoveYearFromLearningObjectives < ActiveRecord::Migration[5.2]
  def change
    remove_column :learning_objectives, :year
  end
end
