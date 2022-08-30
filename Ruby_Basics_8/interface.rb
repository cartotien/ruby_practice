# frozen_string_literal: true

require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'
require_relative 'railway_station'
require_relative 'route'
require_relative 'train_module'
require_relative 'carriage_module'
require_relative 'route_module'
require_relative 'railway_station_module'

class Interface
  include TrainActions
  include CarriageActions
  include RouteActions
  include RailwayStationActions

  MENU = "\nChoose from a number of available options: \n
  1 - Create staions
  2 - Create trains
  3 - Create and manage routes
  4 - Set route for chosen train
  5 - Attach carriages to train
  6 - Detach carriages from train
  7 - Send trains on route
  8 - List all stations and trains
  9 - Manage cargo
  0 - Exit app"

  ACTIONS = %i[
    create_station create_train create_and_manage_routes
    set_route attach_carriages detach_carriages
    send_trains list_stations_and_trains manage_cargo
    exit
  ].freeze

  def initialize
    @trains = []
    @stations = []
    @routes = []
    @carriages = []
    puts "\nWelcome to Rails app."
  end

  def start
    loop do
      puts MENU
      break if validate_user_input { user_action } == 'exit'
    end
  end

  protected

  def exit
    'exit'
  end

  def user_action
    send(ACTIONS[gets.to_i - 1])
  end

  def list_stations_and_trains
    @stations.each do |station|
      puts "Station: #{station.name}"
      station.check_trains do |train|
        puts "Train: #{train.id}, Type: #{train.type}, Cars: #{train.carriage.size}"
        train.check_cars.with_index do |car, index|
          puts "Car: #{index}, Type: #{car.type}, Available: #{car.available_space}, Taken: #{car.occupied_space}"
        end
      end
    end
  end

  def validate_user_input
    yield
  rescue StandardError => e
    puts "Wrong input. Read requirements and retry input.\nError: #{e.message}"
    retry
  end
end
