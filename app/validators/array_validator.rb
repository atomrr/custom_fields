class ArrayValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, values)
    Array(values).each do |value|
      options.each do | _, args|
        validator_options = { attributes: attribute }
        validator_options.merge!(args) if args.is_a?(Hash)
        next if value.blank? && validator_options[:allow_blank]

        validator = ActiveModel::Validations::InclusionValidator.new(validator_options)
        validator.validate_each(record, attribute, value)
      end
    end
  end
end
