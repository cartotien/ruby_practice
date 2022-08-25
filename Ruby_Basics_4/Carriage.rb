class Carriage
  attr_reader :type

  def initialize(type)
    @type = type
  end
end

class PassengerCarriage < Carriage
  def initialize
    super('passenger')
  end
end

class CargoCarriage < Carriage
  def initialize
    super('cargo')
  end
end