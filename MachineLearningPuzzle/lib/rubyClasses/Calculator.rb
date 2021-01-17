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

	def calculateTravelDistance(solutions)
		solutions.each_with_index do | solution, solutionId |
			# puts "Calculating city travel distance for solution: #{solutionId}"
			solution.each_with_index do | city, arrayIndex |
				if solution.length != arrayIndex+1
					nextCity = arrayIndex+1
					# arrayIndex should be +1 aswell on else
				else solution.length == arrayIndex+1
					nextCity = 0
				end
				city[3] = Integer.sqrt((city[1]-solutions[solutionId][nextCity][1])**2 + (city[2]-solutions[solutionId][nextCity][2])**2)
			end
		end
		return solutions
	end

	def solutionTotalTravelTime(solutions, solutionCount)
		solutionResults = Array.new(solutionCount) { |i| 0 }
		solutions.each_with_index do | solution, arrayIndex |
			solution.each do |city|
				solutionResults[arrayIndex] += city[3]
			end
			# puts "Result for solution #{arrayIndex+1} is: #{solutionResults[arrayIndex]}"
			# puts ""

		end
		return solutionResults
	end

	def convertArrayToChart(solutions, bestSolution)
		hr = createChartArray(solutions[bestSolution])


		return hr
	end

	def createChartArray(solution)
		p solution
		hr = []
		solution.each do |city|
  			hr_temp = {:x => city[1], :y => city[2]}
  			hr.push(hr_temp)
  		end
  		hr.push({:x => solution[0][1], :y => solution[0][2]})
		return hr
	end
end