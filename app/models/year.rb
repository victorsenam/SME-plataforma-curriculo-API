class Year < ApplicationRecord
  include YearsEnum

  has_and_belongs_to_many :learning_objectives, join_table: :learning_objectives_years
end
