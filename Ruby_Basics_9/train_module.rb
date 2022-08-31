# frozen_string_literal: true

module TrainActions
  def self.included(base)
    base.include Helpers
    base.include Actions
  end

  module Helpers
    protected

    def show_trains
      @trains.each_with_index { |train, index| puts "Type: #{train.type} - i: #{index}" }
    end

    def train_selector
      puts 'Choose train by index: '
      show_trains
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
  end

  module Actions
    protected

    def create_train
      puts 'Specify train type (cargo/passenger): '
      case gets.chomp.downcase
      when 'cargo'
        train_creator('cargo')
      when 'passenger'
        train_creator('passenger')
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
  end
end
