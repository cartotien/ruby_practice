require_relative 'vendor'

class Carriage
  prepend Vendor

  attr_reader :type, :available_space, :occupied_space

  def initialize(type, available_space)
    @type = type
    @available_space = available_space
    @occupied_space = 0
  end

  def occupy_space(num)
    @available_space -= num
    @occupied_space += num
  end

  def validate!
    raise "There's no more space!" if @available_space <= 0
  end
end
