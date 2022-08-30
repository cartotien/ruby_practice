# frozen_string_literal: true

require_relative 'carriage'

class PassengerCarriage < Carriage
  def initialize(*args)
    super('passenger', *args)
  end

  def occupy_space
    @available_space -= 1
    @occupied_space += 1
  end
end
