class DashboardController < ApplicationController

  def index
  	# Classes
  	calculator = Calculator.new
  	machineAlgorithm = MachineAlgorithm.new

  	# Cities
  	groupSize = 5
  	citySize = 5
  	@solutions = machineAlgorithm.createSolutions(groupSize, citySize)

  	# Algorithm Time
  	@solutions = machineAlgorithm.randomizeSolutionsFull(@solutions)

  end
end
