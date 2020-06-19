class LeagueController < ApplicationController
  def index
    if current_user
    championList = ChampionList.new
    calculator = Calculator.new(championList)
    @prefrences = []
    @prefrences[0] = current_user.prefrences
    @prefrences[1] = "Urgot"
    @prefrences[2] = "Darius"
    @championDataArray = calculator.championWinrate(@prefrences)

    @championDataArray.each do | champion |
      champion[1] = calculator.winrate(champion[2], champion[1])
      champion[2] = calculator.pickrate(champion[2])
    end
    # sort by second value
    puts @championDataArray
    @championDataArray = @championDataArray.sort {|a,b| b[1] <=> a[1]}

   else
     redirect_to new_user_session_path, notice: 'You are not logged in.'
   end
  end

  def showWinrate
  	championList = ChampionList.new
  	calculator = Calculator.new(championList)

  	@dropOff = 2
  	@gamesPlayed = calculator.getTotalGames

  	@championDataArray = calculator.getWinsByAllChampions

  	@championDataArray.each do | champion |
  		champion[1] = calculator.winrate(champion[2], champion[1])
  		champion[2] = calculator.pickrate(champion[2])
  	end
  	# sort by second value
  	@championDataArray = @championDataArray.sort {|a,b| b[1] <=> a[1]}
  end

  def showWinrateTeam
  	championList = ChampionList.new
  	calculator = Calculator.new(championList)

    @gamesPlayed = calculator.getTotalGames

    if params[:q].present?
      @champion1 = params[:q]
      @champion2 = params[:w]
      @championDataArray = calculator.getMatchup(@champion1.chomp.capitalize.strip, [@champion2.chomp.capitalize.strip])
      puts @championDataArray
	  @championDataArray[1] = calculator.winrate(@championDataArray[2], @championDataArray[1])
	  @championDataArray[2] = calculator.pickrate(@championDataArray[2])

  	# sort by second value
    end

  	
# Make page load fast
  	# @championDataArray = [["annie", 50, 1.7], ["ashe", 48, 15,2]]


  end
end
