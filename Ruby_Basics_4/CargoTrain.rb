require_relative 'Train'

class CargoTrain < Train
  def initialize
    super('cargo')
  end

  def attach_carriage(carriage)
    if carriage.is_a? CargoCarriage
      super(carriage)
    else
      puts "Only accepts cargo carriages"
    end
  end
end
