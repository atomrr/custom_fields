class SingleChoice < Field

  def validation_options
    { inclusion: { in: data.to_a } }
  end
end
