class NumberField < Field

  # number validation allowed blank value
  def validation_options
    { numericality: true, allow_blank: true }
  end


end

