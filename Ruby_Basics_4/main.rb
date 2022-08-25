require_relative 'CargoTrain'
require_relative 'Carriage'
require_relative 'PassengerTrain'
require_relative 'RailwayStation'
require_relative 'Route'
require_relative 'Train'

class Main
  def initialize
    @trains = []
    @stations = []
    @routes = []
    puts "\nWelcome to Rails app."
  end

  def start
    loop do
      puts "\nChoose from a number of available options: \n
      1 - Create stations
      2 - Create trains
      3 - Create and manage routes
      4 - Set route for chosen train
      5 - Attach carriages to train
      6 - Detach carriages from train
      7 - Send trains on route
      8 - List all stations and trains
      9 - Exit app"
      break if user_action == '9'
    end
  end

  protected

  def user_action
    case gets.to_i
    when 1
      create_station
    when 2
      create_train
    when 3
      create_and_manage_routes
    when 4
      set_route
    when 5
      attach_carriages
    when 6
      detach_carriages
    when 7
      send_trains
    when 8
      list_stations_and_trains
    when 9
      '9'
    end
  end

  def show_routes
    @routes.each_with_index { |route, index| puts "Route: #{index} - Stations: #{route.show_stations}" }
  end

  def show_stations
    @stations.each_with_index { |station, index| puts "Station: #{station.name} - i: #{index}" }
  end

  def train_selector
    puts 'Choose train by index: '
    @trains.each_with_index { |train, index| puts "Type: #{train.type} - i: #{index}" }
    @trains[gets.to_i]
  end

  def create_station
    puts "Enter station's name: "
    @stations << RailwayStation.new(gets.chomp)
  end

  def create_train
    puts 'Specify train type (cargo/passenger): '
    case gets.chomp.downcase
    when 'cargo'
      @trains << CargoTrain.new
      puts "\nCargo train successfully created"
    when 'passenger'
      @trains << PassengerTrain.new
      puts "\nPassenger train successfully created"
    else
      puts "\nNo such type"
    end
  end

  def create_and_manage_routes
    puts "\n      1 - Manage routes (Add/Delete stations)"
    puts '      2 - Create new route'
    case gets.to_i
    when 1
      manage_routes
    when 2
      @routes << Route.new
    else
      puts 'No such option'
    end
  end

  def manage_routes
    puts 'Choose route by index: '
    show_routes
    route = @routes[gets.to_i]
    puts "\n      1 - Add stations"
    puts '      2 - Delete stations'
    case gets.to_i
    when 1
      puts 'Choose station by index: '
      show_stations
      route.add_station(@stations[gets.to_i])
      puts 'Station was successfully added'
    when 2
      puts 'Choose station by index: '
      p route.show_stations
      route.delete_station(gets.to_i)
      puts 'Station was deleted'
    else
      puts 'No such option'
    end
  end

  def set_route
    train = train_selector
    puts 'Choose route by index: '
    show_routes
    train.route = @routes[gets.to_i]
    puts 'Route was set successfully'
  end

  def attach_carriages
    train = train_selector
    if train.type == 'cargo'
      train.attach_carriage CargoCarriage.new
    else
      train.attach_carriage PassengerCarriage.new
    end
    puts 'Carriage was added successfully'
  end

  def detach_carriages
    train = train_selector
    puts 'Choose carriage by index: '
    train.carriage.each_with_index { |_carriage, index| p index }
    train.detach_carriage(gets.to_i)
    puts 'Carriage was detached successfully'
  end

  def send_trains
    train = train_selector
    puts "\n      1 - Move to next staiton"
    puts '      2 - Move to previous station'
    case gets.to_i
    when 1
      train.move_to_next_station
    when 2
      train.move_to_previous_station
    end
      puts "Train has arrived to #{train.current_station}"
  end

  def list_stations_and_trains
    puts "Trains #{@trains.map(&:type).tally}\nStations #{@stations.map(&:name)}"
  end
end

Main.new.start
