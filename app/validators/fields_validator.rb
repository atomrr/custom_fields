class FieldsValidator < ActiveModel::Validator
  def validate(record)
    unless record.new_record?
      validation_data = record.fields.map do |field|
        [field.name.to_sym, field.validation_options] if field.validation_options.present?
      end.compact
      validation_data.each do |data|
        record.singleton_class.validates *data
      end
    end
  end
end
