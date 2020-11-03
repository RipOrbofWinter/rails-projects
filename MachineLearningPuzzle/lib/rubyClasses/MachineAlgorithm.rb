class MachineAlgorithm

	# To do List
	
	# => Problem: Get all points  
	# => Fitness: Make the distance as low as possible
	# => How to represent solutions: Solution is an array of cities (in a order)

	def createSolutions(groupSize, citySize)
		travelPlan = Array.new(citySize) { |i| [i+1, rand(1..100) , rand(1..100)] }
		return solutions = Array.new(groupSize) { travelPlan }
	end

	def randomizeSolutionsFull(solutions)
		newSolutions = createSolutions(solutions.length, solutions[0].length)
		solutions.each_with_index do |solution, arrayIndex|
			newSolutions[arrayIndex] = solution.shuffle
		end
		return newSolutions
	end
end