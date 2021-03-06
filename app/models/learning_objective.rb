class LearningObjective < ApplicationRecord
  include YearsEnum
  belongs_to :curricular_component
  has_and_belongs_to_many :sustainable_development_goals
  has_and_belongs_to_many :activity_sequences
  has_and_belongs_to_many :activities

  include DestroyValidator # has_and_belongs_to_many doesn't support dependent restrict_with_error

  validates :year, presence: true
  validates :description, presence: true
  validates :curricular_component, presence: true
  validates :code, presence: true, uniqueness: true

  default_scope { order(code: :asc) }

  def code_and_description
    "#{code} - #{description}"
  end

  def self.all_or_with_year(year = nil)
    return all unless year
    where(year: year)
  end

  def self.all_or_with_curricular_component(curricular_component_slug = nil)
    return all unless curricular_component_slug
    joins(:curricular_component).where(
      curricular_components: {
        slug: curricular_component_slug
      }
    )
  end

  def code=(value)
    super(value.to_s.upcase)
  end

  private

  def check_associations(associations = %i[activity_sequences
                                           curricular_component
                                           sustainable_development_goals
                                           activities])
    super(associations)
  end
end
