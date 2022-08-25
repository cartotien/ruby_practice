class PassengerTrain < Train
  def initialize
    super(type='passenger')
  end

  def attach_carriage(carriage)
    if carriage.is_a? PassengerCarriage
      super(carriage)
    else
      puts "Only accepts passenger carriages"
    end
  end
end