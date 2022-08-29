require_relative 'carriage'

class PassengerCarriage < Carriage
  def initialize(vendor)
    super('passenger', vendor)
  end
end
