require_relative 'CargoTrain.rb'
require_relative 'Carriage.rb'
require_relative 'PassengerTrain.rb'
require_relative 'RailwayStation.rb'
require_relative 'Route.rb'
require_relative 'Train.rb'

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
      break if self.user_action == '9'
    end
  end

  private 

  def user_action
    action = gets.to_i
    case action
    when 1
      self.create_station
    when 2
      self.create_train
    when 3
      self.create_and_manage_routes
    when 4
      self.set_route
    when 5 
      self.attach_carriages
    when 6
      self.detach_carriages
    when 7
      self.send_trains
    when 8
      self.list_stations_and_trains
    when 9
      return '9'
    end
  end

  def create_station
    puts "Enter station's name: "
    @stations << RailwayStation.new(name=gets.chomp)
  end

  def create_train
    puts "Specify train type (cargo/passenger): "
    type = gets.chomp.downcase
    
    case type
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
    puts "      1 - Manage routes (Add/Delete stations)
      2 - Create new route\n"
    action = gets.to_i

    case action
    when 1
      self.manage_routes
    when 2
      @routes << Route.new
    else
      puts "No such option"
    end
  end    

  def show_routes
    @routes.each_with_index { |route, i| puts "Route #{i} - #{route.show_stations}" }
  end

  def show_stations
    @stations.each_with_index { |station, i| p [station.name, i] }
  end

  def manage_routes
    puts "Choose route by index: "
    self.show_routes
    route = @routes[gets.to_i]
    
    puts "      1 - Add stations\n2 - Delete stations"
    action = gets.to_i
    case action
    when 1
      puts "Choose station by index: "
      self.show_stations
      route.add_station(@stations[gets.to_i])
      puts "Station was successfully added"
    when 2
      puts "Choose station by index: "
      route.show_stations
      route.delete_station(gets.to_i)
      puts "Station was deleted"
    else
      puts "No such option"
    end
  end

  def train_selector
    puts "Choose train by index: "
    @trains.map.with_index { |train, index| p [train.type, index] }
    @trains[gets.to_i]
  end

  def set_route
    train = self.train_selector
    puts "Choose route by index: #{self.show_routes}"
    train.route = @routes[gets.to_i]
    puts "Route was set successfully"
  end

  def attach_carriages
    train = self.train_selector
    if train.type == 'cargo'
      train.attach_carriage CargoCarriage.new
      puts "Carriage was added successfully"
    else
      train.attach_carriage PassengerCarriage.new
      puts "Carriage was added successfully"
    end
  end

  def detach_carriages
    train = self.train_selector
    puts "Choose carriage by index: "
    train.carriage.each_with_index { |carriage, index| p index }
    train.detach_carriage(gets.to_i)
    puts "Carriage was detached successfully"
  end

  def send_trains
    train = self.train_selector
    puts "      1 - Move to next staiton\n
      2 - Move to previous station"
    action = gets.to_i

    case action
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
