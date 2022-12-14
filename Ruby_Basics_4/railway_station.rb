class RailwayStation
  attr_reader :name, :trains_list

  def initialize(name)
    @name = name.to_s.capitalize
    @trains_list = []
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
end
