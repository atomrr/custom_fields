require 'active_support/concern'

module Fieldable
  extend ActiveSupport::Concern

  included do
    belongs_to :tenant
    has_many :fields, through: :tenant
  end


  def fields_list
    @fields_list ||= field_names.map(&:to_sym)
  end

  def field_names
    @field_names ||= fields.pluck(:name)
  end

  def fields_eq_list
    @fields_eq_list ||= field_names.map{|name| (name + '=').to_sym}
  end

  def method_missing(arg, argv = nil)
    return data.fetch(arg.to_s, nil) if fields_list.include?(arg)

    return self.data = self.data.to_h.merge({arg.to_s[0..-2] => argv}) if fields_eq_list.include?(arg)

    super
  end

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
