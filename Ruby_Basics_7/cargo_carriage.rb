require_relative 'carriage'

class CargoCarriage < Carriage
  def initialize(*args)
    super('cargo', *args)
  end
end
