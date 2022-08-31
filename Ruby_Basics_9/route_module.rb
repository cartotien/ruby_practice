# frozen_string_literal: true

module RouteActions
  def self.included(base)
    base.include Helpers
    base.include Actions
  end

  module Helpers
    protected

    def show_routes
      @routes.each_with_index { |route, index| puts "Route: #{index} - Stations: #{route.show_stations}" }
    end

    def route_selector
      puts 'Choose route by index: '
      show_routes
      @routes[gets.to_i]
    end
  end

  module Actions
    protected

    def create_and_manage_routes
      puts "\n      1 - Manage routes (Add/Delete stations)"
      puts '      2 - Create new route'
      case gets.to_i
      when 1
        manage_routes
      when 2
        @routes << Route.new
      end
    end

    def manage_routes
      route = route_selector
      puts "\n      1 - Add statons"
      puts '      2 - Delete stations'
      case gets.to_i
      when 1
        station_adder(route)
      when 2
        station_remover(route)
      end
    end
  end
end
