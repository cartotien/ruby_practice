# frozen_string_literal: true

require_relative 'vendor'
require_relative 'validation'

class Carriage
  include Validation
  prepend Vendor

  validate :vendor, :format, /[a-z]{7,20}/i

  attr_reader :type, :available_space, :occupied_space

  def initialize(type, available_space)
    @type = type
    @available_space = available_space
    @occupied_space = 0
    validate!
  end

  def occupy_space(num)
    @available_space -= num
    @occupied_space += num
  end
end
