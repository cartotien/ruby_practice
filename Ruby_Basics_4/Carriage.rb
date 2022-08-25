class Carriage
  attr_reader :type
  
  def initialize(type)
    @type = type
  end
end

class PassengerCarriage < Carriage
  def initialize
    super(type='passenger')
  end
end

class CargoCarriage < Carriage
  def initialize
    super(type='cargo')
  end
end