class MultipleChoice < Field
  #requires validation of data - array

  # Utilizes custom ArrayValidator with data from
  def validation_options
    { array: { inclusion: { in: data.to_a } } }
  end
end
