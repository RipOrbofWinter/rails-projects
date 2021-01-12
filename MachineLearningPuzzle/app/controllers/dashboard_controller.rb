class DashboardController < ApplicationController

	### to do
	# add mutation chance
	# Improve crossover selection


  def index
  	## Classes
  	calculator = Calculator.new
  	machineAlgorithm = MachineAlgorithm.new

  	## Vars
  	#cities
  	groupSize = 50
  	@citySize = 8 
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
  	@bestSolution1 =  machineAlgorithm.getFittestSolution(@solutions, @solutionResults)
  	@chartDataArray1 = calculator.convertArrayToChart(@solutions1, @bestSolution1)
  


	p @solutionResults.min(groupSize)

  	## Algorithm Time
  	# Create new city arrays based on best results from last iteration
  	500.times do 
  		@solutions = machineAlgorithm.reproduceSolutions(@solutions, @solutionResults, groupSize, @citySize)
  		@solutions = calculator.calculateTravelDistance(@solutions)
  		@solutionResults = calculator.solutionTotalTravelTime(@solutions, groupSize)
  		puts "Updated Results"
  		p @solutionResults.min(groupSize)
  		puts
  		@bestSolution10 =  machineAlgorithm.getFittestSolution(@solutions, @solutionResults)
  	end

  	# show solutions after rotations
  	@solutions10 = @solutions
  	@solutionResults10 = @solutionResults 	
  	@chartDataArray10 = calculator.createChartArray(machineAlgorithm.bestResultsOrderTracker)
  	# Get data for Progression charts
  	p machineAlgorithm.bestResultsIndexTracker
  	@progressionData = machineAlgorithm.bestResultsIndexTracker
  	@progressionDataFittest = [machineAlgorithm.bestResultsIndexTracker.min, machineAlgorithm.bestResultsIndexTracker.index(machineAlgorithm.bestResultsIndexTracker.min)]
  end
end

