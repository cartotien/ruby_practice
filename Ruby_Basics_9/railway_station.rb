# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'

class RailwayStation
  include InstanceCounter
  include Validation
  validate :name, :format, /[a-zа-я]{5,15}-?[0-9]?/i

  attr_writer :all

  def self.all
    @all ||= []
  end

  attr_reader :name, :trains_list

  def initialize(name)
    @name = name.to_s.capitalize
    @trains_list = []
    validate!
    self.class.all << self
    register_instance
  end

  def check_trains(&block)
    @trains_list.each(&block)
  end

  def park_train(train)
    @trains_list << train if train.is_a? Train
    train.current_station = self
  end

  def send_train(train, where)
    case where
    when 'forward'
      train.move_to_next_station
    when 'backward'
      train.move_to_previous_station
    end
    @trains_list.delete(train)
  end

  def show_train_types
    puts @trains_list.each(&:type).tally
  end
end
