require_relative 'instance_counter'

class RailwayStation
  include InstanceCounter

  NAME_FORMAT = /[a-zа-я]{5,15}-?[0-9]?/i.freeze

  @@all = []

  def self.all
    @@all
  end

  attr_reader :name, :trains_list

  def initialize(name)
    @name = name.to_s.capitalize
    @trains_list = []
    validate!
    @@all << self
    register_instance
  end

  def park_train(train)
    @trains_list << train if train.is_a? Train
    train.current_station = self
  end

  def send_train(train)
    train.move_to_next_station
  end

  def show_train_types
    puts @trains_list.each(&:type).tally
  end

  def validate!
    raise 'Wrong name format' if name !~ NAME_FORMAT
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end
end
