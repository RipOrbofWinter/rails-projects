class DashboardController < ApplicationController

	### to do
	# Add graph displaying growth(or lack there of)
	# add mutation chance
	# Improve crossover selection?


  def index
  	## Classes
  	calculator = Calculator.new
  	machineAlgorithm = MachineAlgorithm.new

  	## Vars
  	#cities
  	groupSize = 50
  	@citySize = 20
  	#array
  	@solutionResults = Array.new(groupSize) { |i| 0 }

  	## Setting up the Initial setting
  	# Create city arrays
  	@solutions = machineAlgorithm.createSolutions(groupSize, @citySize)
  	# Randomize the order
  	@solutions = machineAlgorithm.randomizeSolutionsFull(@solutions, groupSize, @citySize)
  	# Calculate the travel distance between the cities in the new randomized order
  	@solutions = calculator.calculateTravelDistance(@solutions)
  	# Calculate the solutions total result
  	@solutionResults = calculator.solutionTotalTravelTime(@solutions, groupSize)

 
  	## Publish Initial findings to view
  	@solutions1 = @solutions
  	@solutionResults1 = @solutionResults
  	@bestSolution1 =  machineAlgorithm.getFittestSolution(@solutionResults)
  	@chartDataArray1 = calculator.convertArrayToChart(@solutions1, @bestSolution1)
  

  	## Algorithm Time
  	# Create new city arrays based on best results from last iteration
  	10.times do 
  		@solutions = machineAlgorithm.reproduceSolutions(@solutions, @solutionResults, groupSize)
  		
  		# puts "Updated solutions"
  		# p @solutions
  		@solutionResults = calculator.solutionTotalTravelTime(@solutions, groupSize)
  		puts "Updated Results"
  		p @solutionResults.min(groupSize)
  		puts
  		@bestSolution10 =  machineAlgorithm.getFittestSolution(@solutionResults)
  	end

  	# show solutions after 10 rotations
  	@solutions10 = @solutions
  	@solutionResults10 = @solutionResults
  	
  	@chartDataArray10 = calculator.convertArrayToChart(@solutions, @bestSolution1)

	p machineAlgorithm.bestResultsTracker
  	@geneticAlgorithmProgressionData = machineAlgorithm.bestResultsTracker
  end
end

