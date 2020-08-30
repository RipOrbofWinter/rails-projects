Rails.application.routes.draw do
  get 'combat/test'
  get 'pages/setup'
	require "#{Rails.root}/lib/rubyClasses/Unit.rb"
	require "#{Rails.root}/lib/rubyClasses/Zealot.rb"
	require "#{Rails.root}/lib/rubyClasses/Zergling.rb"

	##Set routes
	root 'pages#setup'	
	# get 'pages/index'

	get '/battle_test', 			to: "combat#test"
end
