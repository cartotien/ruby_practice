require_relative 'carriage'

class CargoCarriage < Carriage
  def initialize(vendor)
    super('cargo', vendor)
  end
end
