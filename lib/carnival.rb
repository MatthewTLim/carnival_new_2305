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

  def summary
    carnival_summary = Hash.new(0)
    carnival_summary[:visitors] = []
    carnival_summary[:rides] = []

    @rides.each do |ride|
      carnival_summary[:visitor_count] += ride.rider_log.uniq.count
      carnival_summary[:revenue_earned] += ride.total_revenue
      # require 'pry'; binding.pry
      carnival_summary[:visitors] << {:visitor => ride.rider_log, :favorite_ride => ride, :total_money_spent => ride.rider_log.keys[0].spending_money }
      carnival_summary[:rides] << {:ride => ride, :riders => ride.rider_log, :total_revenue => ride.total_revenue}
    end
    carnival_summary
  end

end