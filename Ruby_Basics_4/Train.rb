class Train
  attr_accessor :speed, :carriage
  attr_writer :current_station
  attr_reader :type, :route

  def initialize(type, speed = 0)
    @type = type.downcase
    @speed = speed
    @carriage = []
  end

  def stop
    @speed = 0
  end

  def stopped?
    @speed.zero?
  end

  def increase_speed(amount)
    @speed += amount
  end

  def attach_carriage(carriage)
    @carriage << carriage
  end

  def detach_carriage(carriage_index)
    @carriage.delete_at(carriage_index)
  end

  def route=(route)
    @route = route if route.is_a?(Route) && !route.route_map.empty?
    @route.route_map[0].park_train(self)
  end

  def current_station
    @current_station.name
  end

  def next_station
    @route.next_station(@current_station).name
  end

  def previous_station
    @route.previous_station(@current_station).name
  end

  def move_to_next_station
    @route.next_station(@current_station).park_train(self)
  end

  def move_to_previous_station
    @route.previous_station(@current_station).park_train(self)
  end

  # Инкапсулировал, потому что предполагаются методы для работы с данными аттрибутами
  private :speed=, :carriage= 
end
