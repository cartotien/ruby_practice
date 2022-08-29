require_relative 'train'

class PassengerTrain < Train
  def initialize(id, vendor)
    super('passenger', id, vendor)
  end

  def attach_carriage(carriage)
    raise 'Only accepts passenger carriages' unless carriage.is_a? PassengerCarriage

    super(carriage)
  end
end
