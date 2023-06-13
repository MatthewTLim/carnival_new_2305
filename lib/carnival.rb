class Carnival

  attr_reader :duration, :rides

  def initialize(duration)
    @duration = duration
    @rides = []
  end

  def add_ride(ride)
    @rides << ride
  end

  def most_popular_ride
    rides_by_rides = Hash.new(0)

    @rides.each do |ride|
      rides_by_rides[ride] += ride.rider_log.values.sum
    end
    rides_by_rides.max_by { |key, value| value }.first
  end

  def most_profitable_ride
    rides_by_profit = Hash.new(0)

    @rides.each do |ride|
      rides_by_profit[ride] += ride.total_revenue
    end
    rides_by_profit.max_by { |key, value| value }.first
  end

  def total_revenue
    total = 0
    @rides.each do |ride|
      total += ride.total_revenue
    end
    total
  end
end