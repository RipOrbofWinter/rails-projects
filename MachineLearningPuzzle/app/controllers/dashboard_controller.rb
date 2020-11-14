class DashboardController < ApplicationController

  def index
  	## Classes
  	calculator = Calculator.new
  	machineAlgorithm = MachineAlgorithm.new

  	## Vars
  	#cities
  	groupSize = 10
  	@citySize = 15
  	#array
  	@solutionResults = Array.new(groupSize) { |i| 0 }

  	## Running the methods
  	# Create city arrays
  	@solutions = machineAlgorithm.createSolutions(groupSize, @citySize)
  	# Randomize the order
  	@solutions = machineAlgorithm.randomizeSolutionsFull(@solutions, groupSize, @citySize)
  	# Calculate the travel distance between the cities in the new randomized order
  	@solutions = calculator.calculateTravelDistance(@solutions)

  	# Calculate the solutions total result
  	@solutionResults = calculator.solutionTotalTravelTime(@solutions, groupSize)

  	#Initial
  	@solutions1 = @solutions
  	@solutionResults1 = @solutionResults
  	@bestSolution1 =  machineAlgorithm.getFittestSolution(@solutionResults)
  	@chartDataArray1 = calculator.convertArrayToChart(@solutions1, @bestSolution1)

  	

  	## Algorithm Time

  	# show solutions after 10 rotations
  	@solutions10 = @solutions
  	@solutionResults10 = @solutionResults
  	@bestSolution10 =  machineAlgorithm.getFittestSolution(@solutionResults)
  	@chartDataArray10 = calculator.convertArrayToChart(@solutions, @bestSolution1)
  	
  	# show solutions after 100 rotations

  	@solutions100 = @solutions
  	@solutionResults100 = @solutionResults

  end
end

