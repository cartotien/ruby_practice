# frozen_string_literal: true

module RailwayStationActions
  def self.included(base)
    base.include Helpers
    base.include Actions
  end

  module Helpers
    protected

    def show_stations
      @stations.each_with_index { |station, index| puts "Station: #{station.name} - i: #{index}" }
    end

    def station_adder(route)
      puts 'Choose station by index: '
      show_stations
      route.add_station(@stations[gets.to_i])
      puts 'Station was successfully added'
    end

    def station_remover(route)
      puts 'Choose station by index: '
      p route.show_stations
      route.delete_station(gets.to_i)
      puts 'Station was deleted'
    end
  end

  module Actions
    protected

    def create_station
      puts "Enter station's name: "
      @stations << RailwayStation.new(gets.chomp)
    end
  end
end
