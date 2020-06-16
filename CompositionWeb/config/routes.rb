Rails.application.routes.draw do


	## Require ruby algoritms/classes
	require "#{Rails.root}/lib/rubyClasses/Calculator.rb"
	require "#{Rails.root}/lib/rubyClasses/ChampionList.rb"
	require "#{Rails.root}/lib/rubyClasses/DataGrabber.rb"
	require "#{Rails.root}/lib/rubyClasses/Match.rb"
	require "#{Rails.root}/lib/rubyClasses/MatchList.rb"
	## Load all controller functions
	resources :league
	devise_for :users
	##Set routes

	root 'pages#index'
	# get 'pages/index'

	get '/generator', 			to: "league#index"
	get '/generator/general', 	to: "league#showWinrate"
	get '/generator/team', 		to: "league#showWinrateTeam"
end