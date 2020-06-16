class Calculator

	def isNegative(quantumState)
		if quantumState < 0
			return 1
		elsif quantumState >= 0
			return 0
		end	
	end

	def toPositive(negativeInteger)
		negativeInteger = 0 - negativeInteger
	end

	# Calculates and saves the total travel time when using neirest neighbour method.
	# currentCity
	def calculateNN(loopCounter, cityToCityTravel, cities, totalTravelTime, startingCityIndex)
		puts
		puts "Draw nearest neighbor starting from city #{startingCityIndex}"
		currentCity = startingCityIndex
		# For every city except the last do:
		(loopCounter).times do
			closestCityCounter = 1
			loop do
				closestCityAttempt = cityToCityTravel[currentCity].min(cityToCityTravel[currentCity].length)[closestCityCounter]

				# print cities[currentCity][2][startingCityIndex]
				print " > #{cityToCityTravel[currentCity].index(closestCityAttempt)}"

				# cities array 0. all cities 1. xLocation ylocation. 2. city connection orders from diffrent starting points
				if cities[cityToCityTravel[currentCity].index(closestCityAttempt)][2][startingCityIndex] == -1
					totalTravelTime[startingCityIndex] += closestCityAttempt
					cities[currentCity][2][startingCityIndex] = cityToCityTravel[currentCity].index(closestCityAttempt)
					puts "\nThe closest city to city #{currentCity} is city #{cityToCityTravel[currentCity].index(closestCityAttempt)} with a distance of: #{closestCityAttempt}"

					currentCity = cityToCityTravel[currentCity].index(closestCityAttempt)
					break
				elsif closestCityCounter >= loopCounter-1
					puts "ClosestCityCounter Overflowed the arrayIndex!"
					break
				end

				closestCityCounter += 1
			end
		end
		puts "\n\nThe total distance starting from city #{startingCityIndex} is: #{totalTravelTime[startingCityIndex]}"
		return [cities, totalTravelTime]
	end
end