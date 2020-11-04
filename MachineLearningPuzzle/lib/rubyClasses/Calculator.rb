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

	def calculateTravelDistance(solutions)
		solutions.each_with_index do | solution, solutionId |
			puts "Calculating city travel distance for solution: #{solutionId}"
			solution.each_with_index do | city, arrayIndex |
				if city.length != arrayIndex
					nextCity = arrayIndex+1
				elsif city.length == arrayIndex
					nextCity = 0
				end
				puts "Calculating distance for city #{city[0]}: "
				distanceX = (city[1] - solutions[solutionId][nextCity][1])
				distanceY = (city[2] - solutions[solutionId][nextCity][2])
				distanceX = toPositive(distanceX) if isNegative(distanceX) == 1
				distanceY = toPositive(distanceY) if isNegative(distanceY) == 1
				city[3] = distanceX + distanceY

				print "City #{city[0]} to City #{solutions[solutionId][nextCity][0]} "
				print "Total Distance: #{city[3]}"
				puts ""
			end
			puts "After #{solutions[0][0][3]}"
		end
		return solutions
	end

	def calculateAllTravelDistance(solutions)
		solutions.each_with_index do | solution, arrayIndex |
			solution = calculateTravelDistance(solutions, arrayIndex)
		end
		return solutions
	end

	def solutionTravelTime(solutions, groupSize)
		solutionResults = Array.new(groupSize) { |i| 0 }
		solutions.each_with_index do | solution, arrayIndex |
			puts solution
			solution.each do |city|
				# puts city[3]
				solutionResults[arrayIndex] += city[3]
			end
			puts "Result for solution #{arrayIndex+1} is: #{solutionResults[arrayIndex]}"

		end
		return solutionResults
	end
end