require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'
require_relative 'railway_station'
require_relative 'route'

class Interface
  def initialize
    @trains = []
    @stations = []
    @routes = []
    @carriages = []
    puts "\nWelcome to Rails app."
  end

  def start
    loop do
      puts "\nChoose from a number of available options: \n
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
      break if user_action == '0'
    end
  end

  protected

  def user_action
    validate_user_input {
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
      manage_cargo
    when 0
      '0'
    end }
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

  def train_creator(train)
    puts "Specify id, format = '555-55' and vendor comma separated"
    details = gets.chomp.split(',')
    case train
    when 'cargo'
      @trains << CargoTrain.new(details[0], details[1])
    when 'passenger'
      @trains << PassengerTrain.new(details[0], details[1])
    end
    puts "\n#{@trains.last} successfully created"
  end

  def carriage_creator(type)
    puts 'Specify available space/seats and vendor comma separated'
    details = gets.chomp.split(',')
    case type
    when 'passenger'
      cargo = PassengerCarriage.new(details[0].to_i, details[1])
      @carriages << cargo
      cargo
    when 'cargo'
      cargo = CargoCarriage.new(details[0].to_i, details[1])
      @carriages << cargo
      cargo
    end
  end

  def carriage_selector
    puts "Choose cargo by index:"
    @carriages.each_with_index { |cargo, index| puts "Cargo: #{index}, Type #{cargo.type}" }
    @carriages[gets.to_i]
  end

  def create_station
    puts "Enter station's name: "
    @stations << RailwayStation.new(gets.chomp)
  end

  def create_train
    puts 'Specify train type (cargo/passenger): '
    case gets.chomp.downcase
    when 'cargo'
      train_creator('cargo')
    when 'passenger'
      train_creator('passenger')
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
    puts "\n      1 - Add statons"
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
      train.attach_carriage(carriage_creator('cargo'))
    else
      train.attach_carriage(carriage_creator('passenger'))
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
    @stations.each { |station| puts "Station: #{station.name}"; 
    station.check_trains { |train| puts "Train: #{train.id}, Type: #{train.type}, Cars: #{train.carriage.size}"; 
    train.check_cars.with_index { |car, index| puts "Car: #{index}, Type: #{car.type}, Space: #{car.available_space}, Taken: #{car.occupied_space}" } } }
  end

  def manage_cargo
    carriage = carriage_selector
    case carriage.type
    when 'passenger'
      puts 'For passenger cars space is occupied by one'
      carriage.occupy_space
    when 'cargo'
      puts 'How much space do you wish to occupy?'
      carriage.occupy_space(gets.to_i)
    end
    Puts 'space was occupied successfully'
  end

  def validate_user_input
    yield
  rescue StandardError => e
    puts "Wrong input. Read requirements and retry input.\nError: #{e.message}"
    retry
  end
end
