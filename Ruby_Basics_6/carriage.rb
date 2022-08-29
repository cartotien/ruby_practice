require_relative 'vendor'

class Carriage
  prepend Vendor

  attr_reader :type

  def initialize(type)
    @type = type
  end

  def validate!
  end
end
