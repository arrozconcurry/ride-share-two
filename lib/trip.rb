require 'csv'
# require_relative 'driver' Got: "rb:2: warning: loading in progress, circular require considered harmful"

module RideShare
  class Trip

    attr_reader :trip_id, :driver_id, :rider_id, :date, :rating

    def initialize(trip_info)
      #have an ID, rider ID, a driver ID, date, rating
      @trip_id = trip_info[:trip_id]
      @driver_id = trip_info[:driver_id]
      @rider_id = trip_info[:rider_id]
      @date = trip_info[:date]

      #Each rating should be within an acceptable range (1-5)
      raise ArgumentError.new("A valid rating is 1-5") if trip_info[:rating] > 5 || trip_info[:rating] < 1
      @rating = trip_info[:rating]
    end

    def self.create_all_trips
      # retrieve all trips from the CSV file
      CSV.read(
      "support/trips.csv",
      headers: true,
      header_converters: :symbol,
      converters: :all
      ).map { |line| line.to_h }
    end

    def self.driver_trips(driver_id)
      # find all trip instances for a given driver ID
      trip_search = self.create_all_trips
      trip_search.find_all do |i|
        i[:driver_id] == driver_id
      end
    end

    def driver
      # retrieve the associated driver instance through the driver ID
      # hmm... my code isn't an instance. it's a hash
      return RideShare::Driver.find(@driver_id)
    end

    def self.rider_trips(rider_id)
      # find all trip instances for a given rider ID
      trip_search = self.create_all_trips
      trip_search.find_all do |i|
        i[:rider_id] == rider_id
      end
    end

    def rider
      # retrieve the associated rider instance through the rider ID
      # TODO
    end

  end
end


################## FAILED CODE ########################

# NOT WORKING TAKE 2
# def self.find_all_driver_trips(driver_id)
#   # find all trip instances for a given driver ID
#   # http://stackoverflow.com/questions/2244915/how-do-i-search-within-an-array-of-hashes-by-hash-values-in-ruby
#   self.create_all_trips.select { |trip| trip[:driver_id] == driver_id }
# end
#
# def find_all_rider_trips(rider_id)
#   # find all trip instances for a given rider ID
#
# end

# NOT WORKING TAKE 1
# def self.find(driver_id)
#   # find a specific driver using their numeric ID
#   self.create_all_drivers[driver_id]
# end
