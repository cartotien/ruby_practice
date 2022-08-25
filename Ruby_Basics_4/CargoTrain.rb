require_relative 'Train.rb'

class CargoTrain < Train
  def initialize
    super(type='cargo')
  end

  def attach_carriage(carriage)
    if carriage.is_a? CargoCarriage
      super(carriage)
    else
      puts "Only accepts cargo carriages"
    end
  end
end
