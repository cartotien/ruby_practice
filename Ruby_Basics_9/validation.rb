# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_writer :validations

    def validations
      @validations ||= []
    end

    def validate(attr, type, option = nil)
      validations << ({ attr: attr, validation_type: type, option: option })
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        check_validity(validation[:validation_type], instance_variable_get("@#{validation[:attr]}"), validation)
      end
    end
  end

  def check_validity(type, attribute_data, validation)
    case type
    when :presence
      raise "Shouldn't be nil nor empty" if attribute_data.nil? || attribute_data.empty?
    when :format
      raise 'Wrong format' if attribute_data !~ validation[:option]
    when :type
      raise 'Wrong class' if attribute_data.class.to_s != validation[:option].to_s
    end
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end
end

# class N
#   include Validation
#   validate :name, :type, Integer
#   def initialize(name)
#     @name = name
#     validate!
#   end
# end
