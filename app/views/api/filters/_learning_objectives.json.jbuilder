json.learning_objectives @learning_objectives do |learning_objective|
  json.id learning_objective.id
  json.code learning_objective.code
  json.description learning_objective.description
  json.color learning_objective.curricular_component.color
end
