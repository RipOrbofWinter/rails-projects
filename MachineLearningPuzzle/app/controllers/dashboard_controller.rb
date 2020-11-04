class DashboardController < ApplicationController

  def index
  	## Classes
  	calculator = Calculator.new
  	machineAlgorithm = MachineAlgorithm.new

  	## Vars
  	#cities
  	groupSize = 5
  	citySize = 5
  	#array
  	@solutionResults = Array.new(groupSize) { |i| 0 }

  	## Running the methods
  	# Create city arrays
  	@solutions = machineAlgorithm.createSolutions(groupSize, citySize)
  	# Randomize the order
  	@solutions = machineAlgorithm.randomizeSolutionsFull(@solutions)
  	# Calculate the travel distance between the cities in the new randomized order
  	@solutions = calculator.calculateTravelDistance(@solutions)

  	# Calculate the solutions total result
  	@solutionResults = calculator.solutionTravelTime(@solutions, groupSize)

  	#Initial
  	@solutions1 = @solutions
  	@solutionResults1 = @solutionResults

  	## Algorithm Time

  	@solutions10 = @solutions
  	@solutionResults10 = @solutionResults

  	@solutions100 = @solutions
  	@solutionResults100 = @solutionResults

  end
end
