class SingleChoice < Field
  #requires validation of data - array

  def validation_options
    { inclusion: { in: data.to_a }, allow_blank: true }
  end
end
