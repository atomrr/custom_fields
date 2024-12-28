class SingleChoice < Field

  def validation_options
    { inclusion: { in: data.to_a }, allow_blank: true }
  end
end
