# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train
  def initialize(id, vendor)
    super('cargo', id, vendor)
  end

  def attach_carriage(carriage)
    raise 'Only accepts cargo carriages' unless carriage.is_a? CargoCarriage

    super(carriage)
  end
end
