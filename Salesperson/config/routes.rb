 
Rails.application.routes.draw do
	## Require ruby algoritms/classes
	require "#{Rails.root}/lib/rubyClasses/Calculator.rb"
	## Load all controller functions
	resources :graphs
	##Set routes
	get 'graphs/index'
	root 'graphs#index'

	get '/chart', to: "graphs#chart"
end