require_relative 'train'

class PassengerTrain < Train
  def initialize
    super('passenger')
  end

  def attach_carriage(carriage)
    if carriage.is_a? PassengerCarriage
      super(carriage)
    else
      puts 'Only accepts passenger carriages'
    end
  end
end