require './lib/visitor'
require './lib/ride'
require './lib/carnival'

RSpec.describe Carnival do
  before do
    @carnival_1 = Carnival.new(7)

    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })

    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor3 = Visitor.new('Penny', 64, '$15')
  end

  describe "#exists" do
    it "#exists" do
      expect(@carnival_1).to be_a(Carnival)
    end

    it "has readable attributes" do
      expect(@carnival_1.duration).to eq(7)
      expect(@carnival_1.rides).to eq([])
    end
  end

  describe "add_rides" do
    it "can add rides to the carnival" do
      @carnival_1.add_ride(@ride1)
      @carnival_1.add_ride(@ride2)
      @carnival_1.add_ride(@ride3)

      expect(@carnival_1.rides).to eq([@ride1, @ride2, @ride3])
    end
  end

  describe "Iteration_3" do
    before do
      @carnival_1.add_ride(@ride1)
      @carnival_1.add_ride(@ride2)
      @carnival_1.add_ride(@ride3)

      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:gentle)
      @visitor3.add_preference(:gentle)
      @visitor1.add_preference(:thrilling)
      @visitor2.add_preference(:thrilling)
      @visitor3.add_preference(:thrilling)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor3)

      @ride2.board_rider(@visitor1)
      @ride2.board_rider(@visitor2)

      @ride3.board_rider(@visitor3)
    end

    describe "#most_popular_ride" do
      it "can tell which ride has been ridden the most" do
        expect(@carnival_1.most_popular_ride).to eq(@ride1)
      end
    end

    describe "#most_profitable_ride" do
      it "can return the ride that is most profitable" do
        expect(@carnival_1.most_profitable_ride).to eq(@ride2)
      end
    end

    describe "#total_revenue" do
      it "can calculate the total revenue of the carnival" do
        expect(@carnival_1.total_revenue).to eq(15)
      end
    end
  end

  describe "#summary" do
    before do
      @carnival_1.add_ride(@ride1)
      @carnival_1.add_ride(@ride2)
      @carnival_1.add_ride(@ride3)

      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:gentle)
      @visitor3.add_preference(:gentle)
      @visitor1.add_preference(:thrilling)
      @visitor2.add_preference(:thrilling)
      @visitor3.add_preference(:thrilling)

      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor2)

      @ride2.board_rider(@visitor1)
      @ride2.board_rider(@visitor1)

      @ride3.board_rider(@visitor3)
      @ride3.board_rider(@visitor3)
    end

    xit "can return a summary of the carnival" do
      expect(@carnival_1.summary).to eq({
        visitor_count: 3,
        revenue_earned: 17,
        visitors: [
          {
            visitor: @visitor1,
            favorite_ride: @ride2,
            total_money_spent: 10
          },
          {
            visitor: @visitor2,
            favorite_ride: @ride1,
            total_money_spent: 3
          },
          {
            visitor: @visitor3,
            favorite_ride: @ride3,
            total_money_spent: 4
          }
        ],
        rides: [
          {
            ride: @ride1,
            riders: [@visitor2],
            total_revenue: 3
          },
          {
            ride: @ride2,
            riders: [@visitor1],
            total_revenue: 10
          },
          {
            ride: @ride3,
            riders: [@visitor3],
            total_revenue: 4
          }
        ]
      })
    end
  end
end
