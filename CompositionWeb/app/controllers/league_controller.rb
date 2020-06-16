class LeagueController < ApplicationController
  def index
  	@championDataArray = [["annie", 50, 1.7], ["ashe", 48, 15,2]]
  end

  def showWinrate
  	championList = ChampionList.new
  	calculator = Calculator.new(championList)

  	@dropOff = 2

  	@championDataArray = calculator.getWinsByAllChampions

  	@championDataArray.each do | champion |
  		champion[1] = calculator.winrate(champion[2], champion[1])
  		champion[2] = calculator.pickrate(champion[2])
  	end
  	# sort by second value
  	@championDataArray = @championDataArray.sort {|a,b| b[1] <=> a[1]}
  end

  def showWinrateTeam
  end
end
