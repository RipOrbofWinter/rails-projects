class GraphsController < ApplicationController

# Update index, cleanup code, upload to github, 

  def index
	calculator = Calculator.new

	@loopCounter = 30
	@fieldsize = 1000
	@totalTravelTime = 0
	graph = Array.new(@fieldsize) { Array.new(@fieldsize, 0)  }
	@cities = Array.new(@loopCounter) { [0, 0, 420] }
	@cityToCityTravel = Array.new(@loopCounter) { Array.new(@loopCounter, 0) }

	times = 0 
	while times < @loopCounter do
		randomX = rand(@fieldsize)
		randomY = rand(@fieldsize)
		if graph[randomX][randomY] != 1
			graph[randomX][randomY] = 1
			@cities[times][0] = randomX
			@cities[times][1] = randomY
			times +=1
		elsif graph[randomX][randomY] == 1
			times -=1
		end
	end

	currentCity = 0

	while currentCity < @loopCounter do
		puts "Calculating nearest city for city #{currentCity}: "
		puts 

		times = 0
		while times < @cities.length do
			if currentCity != times
				distanceX = (@cities[currentCity][0] - @cities[times][0])
				distanceY = (@cities[currentCity][1] - @cities[times][1])
				distanceX = calculator.toPositive(distanceX) if calculator.isNegative(distanceX) == 1
				distanceY = calculator.toPositive(distanceY) if calculator.isNegative(distanceY) == 1
				@cityToCityTravel[currentCity][times] = distanceX + distanceY

				print "City #{currentCity} to City: #{times} "
				print "Distance x: #{distanceX} "
				print "Distance y: #{distanceY} "
				print "Total Distance: #{distanceX + distanceY}"
				puts ""
			end
			times += 1
		end
		currentCity += 1
	end

	
	puts "Draw nearest neighbor"
	currentCity = 0
	(@loopCounter-1).times do
		closestCityCounter = 1
		loop do
			closestCityAttempt = @cityToCityTravel[currentCity].min(30)[closestCityCounter]

			print @cities[currentCity][2]
			puts @cityToCityTravel[currentCity].index(closestCityAttempt)

			if @cities[@cityToCityTravel[currentCity].index(closestCityAttempt)][2] == 420
				@totalTravelTime += closestCityAttempt
				@cities[currentCity][2] = @cityToCityTravel[currentCity].index(closestCityAttempt)
				puts "The closest city to city #{currentCity} is city #{@cityToCityTravel[currentCity].index(closestCityAttempt)} with a distance of: #{closestCityAttempt}"

				currentCity = @cityToCityTravel[currentCity].index(closestCityAttempt)
				break
			end
			closestCityCounter += 1
		end

	end

		
	print @cities
	puts
	puts @totalTravelTime

  end

  def chart
  	calculator = Calculator.new
	
  	# Set constraints
	@loopCounter = 30
	@fieldsize = 500

	# Set imoportant arrays
	@totalTravelTime = Array.new(@loopCounter, 0)
	graph = Array.new(@fieldsize) { Array.new(@fieldsize, 0)  }
	@cities = Array.new(@loopCounter) { [0, 0, Array.new(@loopCounter, -1)] }
	@cityToCityTravel = Array.new(@loopCounter) { Array.new(@loopCounter, 0) }

	# Outdated
	times = 0 
	while times < @loopCounter do
		randomX = rand(@fieldsize)
		randomY = rand(@fieldsize)
		if graph[randomX][randomY] != 1
			graph[randomX][randomY] = 1
			@cities[times][0] = randomX
			@cities[times][1] = randomY
			times +=1
		elsif graph[randomX][randomY] == 1
			times -=1
		end
	end


	currentCity = 0
	while currentCity < @loopCounter do
		puts "Calculating nearest city for city #{currentCity}: "
		puts 

		times = 0
		while times < @cities.length do
			if currentCity != times
				distanceX = (@cities[currentCity][0] - @cities[times][0])
				distanceY = (@cities[currentCity][1] - @cities[times][1])
				distanceX = calculator.toPositive(distanceX) if calculator.isNegative(distanceX) == 1
				distanceY = calculator.toPositive(distanceY) if calculator.isNegative(distanceY) == 1
				@cityToCityTravel[currentCity][times] = distanceX + distanceY

				print "City #{currentCity} to City: #{times} "
				print "Distance x: #{distanceX} "
				print "Distance y: #{distanceY} "
				print "Total Distance: #{distanceX + distanceY}"
				puts ""
			end
			times += 1
		end
		currentCity += 1
	end

	# solve the problem by iterating trough all city positions
	startingCity = 0
	dataArray = []
	(@loopCounter).times do
		dataArray = calculator.calculateNN(@loopCounter, @cityToCityTravel, @cities, @totalTravelTime, startingCity)
		startingCity += 1
	end



	puts "\n List of all cities locations"
	@cities.each_with_index do |city, index|

		print "city: #{index} data: #{city[2]}"
		puts
	end
	puts "List of totalTravelTime by starting point"
	puts @totalTravelTime.min(@totalTravelTime.length)
  end
end