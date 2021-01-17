class MachineAlgorithm

	# => Problem: Get all points  
	# => Fitness: Make the distance as low as possible
	# => How to represent solutions: Solution is an array of cities (in a order)

	## Online advice against repetetion:
	# It is recommended to have crossover probability above 0.8 and mutation below 0.3 for good convergence.
	# You may try more crossover points, as 2 or 3, which would give you more variability.

	attr_accessor :bestResultsIndexTracker, :bestResultsOrderTracker

	def initialize()
		@bestResultsIndexTracker = [Float::INFINITY]
		@bestResultsOrderTracker = []
	end

	def createSolutions(solutionCount, cityCount)
		travelPlan = Array.new(cityCount) { |i| [rand(1..1000), rand(1..1000)] }
		return solutions = Array.new(solutionCount) { Array.new(cityCount) { |i| [i+1, travelPlan[i][0], travelPlan[i][1], "Not calculated"] } }
	end

	def randomizeSolutionsFull(solutions, solutionCount, cityCount)
		newSolutions = createSolutions(solutionCount, cityCount)
		solutions.each_with_index do |solution, arrayIndex|
			newSolutions[arrayIndex] = solution.shuffle
		end
		return newSolutions
	end

	def getFittestSolution(solutions, solutionResults)
		bestSolution = solutionResults.index(solutionResults.min)
		if solutionResults.min < @bestResultsIndexTracker.min 
			p "New Best Found: #{solutionResults.min}"
			@bestResultsOrderTracker = solutions[bestSolution]
		end
		@bestResultsIndexTracker.push(solutionResults.min)
		return bestSolution
	end

	def getSecondBestSolution(solutions, solutionResults, solutionCount)
		x = 1
		rand(1..10)
		loop do
			if solutionResults.min(solutionCount)[x] != solutionResults.min
				secondBestSolution = solutionResults.index(solutionResults.min(solutionCount)[x])
				return secondBestSolution
			elsif x >= solutionCount-1
				break
			else
				# print "The #{index} best solution is equal to the first, skipping... "
			end
			x+=1
		end
		puts "All results are the same! Returning 2nd best just in case"
		return solutionResults.index(solutionResults.min)
	end


	def reproduceSolutions(solutions, solutionResults, solutionCount, cityCount)
	# 1. select top2 results
		bestSolution = solutionResults.index(solutionResults.min)
		secondBestSolution = getSecondBestSolution(solutions, solutionResults, solutionCount)

		bestSolutions = [bestSolution, secondBestSolution]
		puts "Selected best solution indexes#{bestSolutions}, values: #{solutions[bestSolutions[0]]}"

	# 2. select part of each to transplant
		newSolutions = []
		puts "Start of transplanting"		
		solutionCount.times do
		 # 2.1. crossover chance
			if rand(0..100) <= 100
				newSolution = Array.new(cityCount)
				swathRange = [0,0]
				swathRange[0] = rand(0..cityCount-1)
				swathRange[1] =rand(swathRange[0]..cityCount)
				newSolution.insert(swathRange[0], solutions[bestSolutions[0]][swathRange[0]..swathRange[1]])
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
						if cityIndex >= swathRange[0]
							newSolution.insert(swathRange[0]-1, city)
						else
							newSolution.insert(swathRange[0]+swathRange[1]+1, city)
						end
					end
				end
				newSolution.compact!
				newSolutions.push(newSolution)
			else
				if rand(1..2) == 1
					newSolutions.push(solutions[bestSolutions[0]])
				else
					newSolutions.push(solutions[bestSolutions[1]])
				end
			end
		end
	# 4 mutatation chance
		newSolutions = mutateSolution(newSolutions)
	# 5. Return to controller
		puts "End of transplanting"	
		return newSolutions
	end

	def reproduceSolutionsAlt(solutions, solutionResults, solutionCount, cityCount)
		## 'Order 1 Crossover' with crossover guide, math still by me.
		# 1. select top2 results
		bestSolution = solutionResults.index(solutionResults.min)
		secondBestSolution = getSecondBestSolution(solutions, solutionResults, solutionCount)

		bestSolutions = [bestSolution, secondBestSolution]
		# puts "Selected best solution indexes#{bestSolutions}, values: #{solutions[bestSolutions[0]]}"

		# 2. select part of each to transplant
		newSolutions = [Array.new(cityCount)]
		# newSolutions = [Array.new(cityCount), Array.new(cityCount)]
		# formula for getting a swath range that is not stuck around the center!
		# currently is always equal to 50% of total city size, can be improved later!
		swath = rand(cityCount)
		if swath > cityCount/2
			swath-=cityCount
		end
		swath-=1
		swathRange = swath..swath+cityCount/2-1
		# If it breaks this is why
		swathEndRange = swath+cityCount/2..swath+cityCount-1

		swathRange.each do	|i|
			newSolutions[0].delete_at(i)
			newSolutions[0].insert(i, solutions[bestSolutions[0]][i])
			puts solutions[bestSolutions[0]][i][0]
		end
		# 3. fill in remaining spots with unused cities, looping through the solution till all spots are filled.


		swathEndRange.each do	|i|
			tempCityCount = []
			tempCounter = 0
			if i >= cityCount
				i = i-cityCount
			end
			newSolutions[0].delete_at(i)
			newSolutions[0].each do |tempCity|
				if tempCity != nil
					tempCityCount.push(tempCity[0])
				end
			end
			# slower but more accurate, maybe look for diffrent solution later
			cityCount.times do
				if tempCounter+i >=cityCount
					tempCounter-=cityCount
				end
				if tempCityCount.include?(solutions[bestSolutions[1]][i+tempCounter][0])
					tempCounter+=1						
				end
			end
			puts solutions[bestSolutions[1]][i+tempCounter][0]
			newSolutions[0].insert(i, solutions[bestSolutions[1]][i+tempCounter])
		end

		# 3.2 remove 2 worst results from last gen
		maxSolutionCounter = 0
		1.times do
			solutions.delete_at(solutionResults.index(solutionResults.max(2)[maxSolutionCounter]))
			maxSolutionCounter +=1
		end
		# 3.3 place new solutions into generation
		newSolutions.each do |newSolution|
			solutions.push(newSolution)
		end

		# 4 mutatation chance
		solutions = mutateSolution(solutions)
		# 5. Return to controller
		puts "End of transplanting"	
		return solutions
	end

	def mutateSolution(solutions)
		# x% chance per city to change spots
		return solutions
	end
end