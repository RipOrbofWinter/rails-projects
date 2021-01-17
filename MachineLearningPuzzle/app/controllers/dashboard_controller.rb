class DashboardController < ApplicationController

	### to do
	## Order 1 Crossover
	# add mutation chance
	# Remake crossover with guide done
		# check delete function why what disapears (not just the last one)
	# check createChartArray why it is not showing the correct graph
		# check TravelDistance Calculation since (the last value) seems to chnage somewhere between its original gen and createChartArray()


  def index
  	## Classes
  	calculator = Calculator.new
  	machineAlgorithm = MachineAlgorithm.new

  	## Vars
  	#cities
  	solutionCount = 50
  	@cityCount = 8 
  	#array
  	@solutionResults = Array.new(solutionCount) { |i| 0 }

  	## Setting up the Initial setting
  	# Create city arrays
  	@solutions = machineAlgorithm.createSolutions(solutionCount, @cityCount)
  	# Randomize the order
  	@solutions = machineAlgorithm.randomizeSolutionsFull(@solutions, solutionCount, @cityCount)
  	# Calculate the travel distance between the cities in the new randomized order
  	@solutions = calculator.calculateTravelDistance(@solutions)
  	# Calculate the solutions total result
  	@solutionResults = calculator.solutionTotalTravelTime(@solutions, solutionCount)

 
  	## Publish Initial findings to view
  	@solutions1 = @solutions
  	@solutionResults1 = @solutionResults
  	@bestSolution1 =  machineAlgorithm.getFittestSolution(@solutions, @solutionResults)
  	@chartDataArray1 = calculator.convertArrayToChart(@solutions1, @bestSolution1)
  


	p @solutionResults.min(solutionCount)

  	## Algorithm Time
  	# Create new city arrays based on best results from last iteration
  	500.times do 
  		@solutions = machineAlgorithm.reproduceSolutions(@solutions, @solutionResults, solutionCount, @cityCount)
  		@solutions = calculator.calculateTravelDistance(@solutions)
  		@solutionResults = calculator.solutionTotalTravelTime(@solutions, solutionCount)
  		puts "Updated Results"
  		p @solutionResults.min(solutionCount)
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

  def altSolution
  	## Classes
  	calculator = Calculator.new
  	machineAlgorithm = MachineAlgorithm.new

  	## Vars
  	#cities
  	solutionCount = 10
  	@cityCount = 8 
  	#array
  	@solutionResults = Array.new(solutionCount) { |i| 0 }

  	## Setting up the Initial setting
  	# Create city arrays
  	@solutions = machineAlgorithm.createSolutions(solutionCount, @cityCount)
  	# Randomize the order
  	@solutions = machineAlgorithm.randomizeSolutionsFull(@solutions, solutionCount, @cityCount)
  	# Calculate the travel distance between the cities in the new randomized order
  	@solutions = calculator.calculateTravelDistance(@solutions)
  	# Calculate the solutions total result
  	@solutionResults = calculator.solutionTotalTravelTime(@solutions, solutionCount)

 
  	## Publish Initial findings to view
  	@solutions1 = @solutions
  	@solutionResults1 = @solutionResults
  	@bestSolution1 =  machineAlgorithm.getFittestSolution(@solutions, @solutionResults)
  	@chartDataArray1 = calculator.convertArrayToChart(@solutions1, @bestSolution1)
  

	p @solutionResults.min(solutionCount)

  	## Algorithm Time
  	# Create new city arrays based on best results from last iteration
  	200.times do 
  		@solutions = machineAlgorithm.reproduceSolutionsAlt(@solutions, @solutionResults, solutionCount, @cityCount)
  		@solutions = calculator.calculateTravelDistance(@solutions)
  		@solutionResults = calculator.solutionTotalTravelTime(@solutions, solutionCount)
  		puts "Updated Results"
  		p @solutionResults.min(@solutionResults.count)
  		puts
  		@bestSolution10 =  machineAlgorithm.getFittestSolution(@solutions, @solutionResults)
  	end

  	machineAlgorithm.bestResultsIndexTracker.delete_at(0)

  	# show solutions after rotations
  	@solutions10 = @solutions
  	@solutionResults10 = @solutionResults 	
  	@chartDataArray10 = calculator.createChartArray(machineAlgorithm.bestResultsOrderTracker)
  	# Get data for Progression charts
  	@progressionData = machineAlgorithm.bestResultsIndexTracker
  	puts machineAlgorithm.bestResultsIndexTracker
  	@progressionDataFittest = [machineAlgorithm.bestResultsIndexTracker.min, machineAlgorithm.bestResultsIndexTracker.index(machineAlgorithm.bestResultsIndexTracker.min)]
  end
end

