class MachineAlgorithm

	# To do List
	
	# => Problem: Get all points  
	# => Fitness: Make the distance as low as possible
	# => How to represent solutions: Solution is an array of cities (in a order)

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
end