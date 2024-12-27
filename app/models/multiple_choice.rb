class MultipleChoice < Field

  def validation_options
    { array: { inclusion: { in: data.to_a } } }
  end
end
