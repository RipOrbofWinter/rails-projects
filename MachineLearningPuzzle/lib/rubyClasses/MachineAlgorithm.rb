class MachineAlgorithm

	# => Problem: Get all points  
	# => Fitness: Make the distance as low as possible
	# => How to represent solutions: Solution is an array of cities (in a order)

	## Online advice against repetetion:
	# It is recommended to have crossover probability above 0.8 and mutation below 0.3 for good convergence.
	# You may try more crossover points, as 2 or 3, which would give you more variability.

	def createSolutions(groupSize, citySize)
		travelPlan = Array.new(citySize) { |i| [rand(1..1000), rand(1..1000)] }
		return solutions = Array.new(groupSize) { Array.new(citySize) { |i| [i+1, travelPlan[i][0], travelPlan[i][1], "Not calculated"] } }
	end

	def randomizeSolutionsFull(solutions, groupSize, citySize)
		newSolutions = createSolutions(groupSize, citySize)
		solutions.each_with_index do |solution, arrayIndex|
			newSolutions[arrayIndex] = solution.shuffle
		end
		return newSolutions
	end

	def getFittestSolution(solutionResults)
		bestSolution = solutionResults.index(solutionResults.min)
		puts "Best Starting solution is: #{bestSolution}"
		puts
		return bestSolution
	end

	def getSecondBestSolution(solutions, solutionResults, groupSize)
		x = 1
		loop do
			if solutionResults.min(groupSize)[x] != solutionResults.min
				secondBestSolution = solutionResults.index(solutionResults.min(groupSize)[x])
				return secondBestSolution
			elsif x >= groupSize-1
				break
			else
				# print "The #{index} best solution is equal to the first, skipping... "
			end
			x+=1
		end
		puts "All results are the same! Returning 2nd best just in case"
		return solutionResults.index(solutionResults.min)
	end


	def reproduceSolutions(solutions, solutionResults, groupSize)
	# 1. select good solution results
		bestSolution = solutionResults.index(solutionResults.min)
		secondBestSolution = getSecondBestSolution(solutions, solutionResults, groupSize)

		bestSolutions = [bestSolution, secondBestSolution]
	# 2. select part of each to transplant
		newSolutions = []
		puts "Start of transplanting"		
		groupSize.times do
		 # 2.1. crossover chance
			if rand(100) <= 85
				solutionMinTransplant = ((groupSize.to_f)/100*20).to_i
				solutionHalfTransplant = ((groupSize.to_f)/2).to_i
				solutionMaxTransplant = ((groupSize.to_f)/100*80).to_i

				newSolution = Array.new(groupSize)
				tempRandom = [rand(solutionMinTransplant-1...solutionHalfTransplant-1)]
				tempRandom.push(rand(solutionHalfTransplant+1..solutionMaxTransplant))
				newSolution.insert(tempRandom[0], solutions[bestSolutions[0]][tempRandom[0]..tempRandom[1]])
				newSolution = newSolution.flatten(1)
				# 3. fill in remaining spots with unused cities, looping through the solution till all spots are filled.
				solutions[bestSolutions[1]].each_with_index do |city, cityIndex|
					tempCityCount = []
					newSolution.each do |tempCity|
						if tempCity != nil
							tempCityCount.push(tempCity[0])
						end
					end
					if tempCityCount.include?(city[0]) == false
						if cityIndex >= tempRandom[0]
							newSolution.insert(tempRandom[0]-1, city)
						else
							newSolution.insert(tempRandom[0]+tempRandom[1]+1, city)
						end
					end
				end
				newSolution.compact!
				newSolutions.push(newSolution)
			else
				newSolutions.push(solutions[bestSolutions[0]])
			end
		end
	# 4 mutatation chance
		newSolutions = mutateSolution(newSolutions)
	# 5. Return to controller
		puts "End of transplanting"	
		return newSolutions
	end

	def mutateSolution(solutions)
		# x% chance per city to change spots
		return solutions
	end
end