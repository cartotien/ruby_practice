require_relative 'carriage'

class PassengerCarriage < Carriage
  def initialize
    super('passenger', vendor)
  end
end
