Rails.application.routes.draw do
  
    ## Require ruby algoritms/classes
	require "#{Rails.root}/lib/rubyClasses/Calculator.rb"
	require "#{Rails.root}/lib/rubyClasses/MachineAlgorithm.rb"
  
	## Load all controller functions
	resources :dashboard

	##Set routes
	root 	'dashboard#index'
	get 	'/alt' => 'dashboard#altSolution'
	# get '/chart', to: "graphs#chart"
end
