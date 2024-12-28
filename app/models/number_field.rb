class NumberField < Field
  # validates :name, numericality: true
  # validates :name, inclusion: { in: %w(small medium large) }

  # def self.validator_prototype
  #   ActiveRecord::Validations::NumericalityValidator.new(attributes: [:_empty_attribute])
  # end

  def validation_options
    { numericality: true, allow_blank: true }
  end


end

