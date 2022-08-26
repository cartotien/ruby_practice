require_relative 'instance_counter'

class Route
  include InstanceCounter

  initialize_counter

  attr_reader :route_map

  def initialize
    @route_map = []
    register_instance
  end

  def show_stations
    @route_map.map(&:name)
  end

  def add_station(station)
    @route_map << station if station.is_a? RailwayStation
  end

  def delete_station(station_index)
    @route_map.delete_at(station_index)
  end

  def next_station(station)
    @route_map[@route_map.index(station) + 1]
  end

  def previous_station(station)
    @route_map[@route_map.index(station) - 1]
  end
end
