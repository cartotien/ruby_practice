# frozen_string_literal: true

require_relative 'vendor'
require_relative 'instance_counter'
require_relative 'validation'

class Train
  prepend Vendor
  include InstanceCounter
  include Validation

  validate :id, :presence
  validate :id, :format, /[0-9a-zа-я]{3}-?[a-zа-я0-9]{2}/i
  validate :vendor, :format, /[a-z]{7,20}/i

  def self.all
    @all ||= []
  end

  def self.find(id)
    @all.find { |train| train.id == id }
  end

  attr_accessor :speed, :carriage
  attr_writer :current_station, :all
  attr_reader :type, :route, :id

  def initialize(type, id, speed = 0)
    @type = type.downcase
    @speed = speed
    @carriage = []
    @id = id
    self.class.all << self
    register_instance
  end

  def check_cars(&block)
    @carriage.each(&block)
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
    @route.next_station(@current_station)
  end

  def previous_station
    @route.previous_station(@current_station)
  end

  def move_to_next_station
    next_station.park_train(self)
  end

  def move_to_previous_station
    previous_station.park_train(self)
  end

  protected :speed=, :carriage=
end