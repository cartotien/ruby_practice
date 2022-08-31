# frozen_string_literal: true

module CarriageActions
  def self.included(base)
    base.include Helpers
    base.include Actions
  end

  module Helpers
    protected

    def carriage_selector
      puts 'Choose carriage by index:'
      @carriages.each_with_index { |cargo, index| puts "Cargo: #{index}, Type #{cargo.type}" }
      @carriages[gets.to_i]
    end

    def carriage_creator(type)
      puts 'Specify available space/seats and vendor comma separated'
      details = gets.chomp.split(',')
      case type
      when 'passenger'
        @carriages << cargo = PassengerCarriage.new(details[0].to_i, details[1])
        cargo
      when 'cargo'
        @carriages << cargo = CargoCarriage.new(details[0].to_i, details[1])
        cargo
      end
    end
  end

  module Actions
    protected

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
      puts 'Space was occupied successfully'
    end
  end
end
