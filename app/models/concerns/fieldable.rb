require 'active_support/concern'

module Fieldable
  extend ActiveSupport::Concern

  included do
    belongs_to :tenant
    has_many :fields, through: :tenant
  end

  # Build custom field symbol list
  def fields_list
    @fields_list ||= field_names.map(&:to_sym)
  end

  def field_names
    @field_names ||= fields.pluck(:name)
  end

  # Build custom field symbol list for assignment
  def fields_eq_list
    @fields_eq_list ||= field_names.map{|name| (name + '=').to_sym}
  end

  # Patches method_missing to add processing of
  # retrieving and assignment custom fields values
  def method_missing(arg, argv = nil)
    return data.to_h.fetch(arg.to_s, nil) if fields_list.include?(arg)

    return self.data = self.data.to_h.merge({arg.to_s[0..-2] => argv}) if fields_eq_list.include?(arg)

    super
  end

  # Patches valid? method to add custom fields
  # validations on specific instance
  # by collecting field name as a key
  # and validation_options as options for ActiveSupport validations
  def valid?(context = nil)
    unless self.new_record?
      validation_data = self.fields.map do |field|
        [field.name.to_sym, field.validation_options] if field.validation_options.present?
      end.compact
      validation_data.each do |data| #prevent addition of extra validators
        self.singleton_class.validates *data
      end
    end
    super
  end

end
