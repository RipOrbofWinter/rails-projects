class Calculator
	def initialize(championEnum)
		@champion_options = championEnum
		@totalGames = YAML.load(File.read("#{Rails.root}/lib/rubyClasses/MatchHistory.yml"))
		@totalGames = @totalGames.history.count
	end

	def getTotalGames
		return @totalGames
	end

	def to_chN(championId)
        @champion_options.each { |n| 
            if n[0] == championId
                return n[1]
            end
        }
	end

	def to_chI(championName)
        @champion_options.each { |n| 
            if n[1] == championName
                return n[0]
            end
        }
        return nil
	end
	
	def winrate(matches, wins)
		percentage = (wins.to_f / matches)*100
		return percentage.round(1)
	end

	def pickrate(matches)
		percentage = (matches.to_f / @totalGames)*100
		return percentage.round(1)
	end

# 	get 1 champion + matchup champions(array)
	def getMatchup(userChampion, matchupChampions)
		championResults = [0, 0, 0]
		
		puts "Searching for matches between #{userChampion} and #{matchupChampions[0]}..."
		championResults[0] = to_chI(userChampion)
		matchupChampions[0] = to_chI(matchupChampions[0])
		matchList = YAML.load(File.read("#{Rails.root}/lib/rubyClasses/MatchHistory.yml"))


		matchList.history.each do |i|
			counter = 0
			while counter <=5
				if i.blueTeam[counter] == championResults[0]
					5.times do |i2|
						if i.redTeam[i2+1] == matchupChampions[0]
							championResults[2] +=1
							if i.winner == "blue"
								championResults[1] +=1
							end
						end
					end
				elsif i.redTeam[counter] == championResults[0]
					5.times do |i2|
						if i.blueTeam[i2+1] == matchupChampions[0]
							championResults[2] +=1
							if i.winner == "red"
								championResults[1] +=1
							end
						end
					end
				end
				counter +=1
			end
		end
		championResults[0] = userChampion
		return championResults
	end

	def getWinsByAllChampions
		championResults = Array.new(148) { [0, 0, 0] }

	    @champion_options.each_with_index { |n, index| 
	        championResults[index][0] = n[0]
	    }

		puts "Searching for matches..."
		matchList = YAML.load(File.read("#{Rails.root}/lib/rubyClasses/MatchHistory.yml"))
		matchList.history.each do |i|
			if i.winner == "blue"
				# search for the champions index with .index with a block that selects the first array field
				# add 1 win to winners counter
				championResults[championResults.index{ |x| x[0] == i.blueTeam[0]}][1] += 1
				championResults[championResults.index{ |x| x[0] == i.blueTeam[1]}][1] += 1
				championResults[championResults.index{ |x| x[0] == i.blueTeam[2]}][1] += 1
				championResults[championResults.index{ |x| x[0] == i.blueTeam[3]}][1] += 1
				championResults[championResults.index{ |x| x[0] == i.blueTeam[4]}][1] += 1
				# add 1 game played to all counters
				championResults[championResults.index{ |x| x[0] == i.blueTeam[0]}][2] += 1
				championResults[championResults.index{ |x| x[0] == i.blueTeam[1]}][2] += 1
				championResults[championResults.index{ |x| x[0] == i.blueTeam[2]}][2] += 1
				championResults[championResults.index{ |x| x[0] == i.blueTeam[3]}][2] += 1
				championResults[championResults.index{ |x| x[0] == i.blueTeam[4]}][2] += 1
				championResults[championResults.index{ |x| x[0] == i.redTeam[0]}][2] += 1
				championResults[championResults.index{ |x| x[0] == i.redTeam[1]}][2] += 1
				championResults[championResults.index{ |x| x[0] == i.redTeam[2]}][2] += 1
				championResults[championResults.index{ |x| x[0] == i.redTeam[3]}][2] += 1
				championResults[championResults.index{ |x| x[0] == i.redTeam[4]}][2] += 1
			elsif i.winner == "red"
				championResults[championResults.index{ |x| x[0] == i.redTeam[0]}][1] += 1
				championResults[championResults.index{ |x| x[0] == i.redTeam[1]}][1] += 1
				championResults[championResults.index{ |x| x[0] == i.redTeam[2]}][1] += 1
				championResults[championResults.index{ |x| x[0] == i.redTeam[3]}][1] += 1
				championResults[championResults.index{ |x| x[0] == i.redTeam[4]}][1] += 1
				championResults[championResults.index{ |x| x[0] == i.blueTeam[0]}][2] += 1
				championResults[championResults.index{ |x| x[0] == i.blueTeam[1]}][2] += 1
				championResults[championResults.index{ |x| x[0] == i.blueTeam[2]}][2] += 1
				championResults[championResults.index{ |x| x[0] == i.blueTeam[3]}][2] += 1
				championResults[championResults.index{ |x| x[0] == i.blueTeam[4]}][2] += 1
				championResults[championResults.index{ |x| x[0] == i.redTeam[0]}][2] += 1
				championResults[championResults.index{ |x| x[0] == i.redTeam[1]}][2] += 1
				championResults[championResults.index{ |x| x[0] == i.redTeam[2]}][2] += 1
				championResults[championResults.index{ |x| x[0] == i.redTeam[3]}][2] += 1
				championResults[championResults.index{ |x| x[0] == i.redTeam[4]}][2] += 1
			else
			end
		end
		puts "Finished looping all matches"
		championResults.each do |champion|
			champion[0] = to_chN(champion[0])
		end
		return championResults
	end

	def getWinsByChampion(championId)
		matches = 0
		wins = 0
		puts "Searching for matches..."
		matchList = YAML.load(File.read("#{Rails.root}/lib/rubyClasses/MatchHistory.yml"))
		matchList.history.each do |i|
			counter = 0
			while counter <=5
				if i.blueTeam[counter] == championId
					matches +=1
					if i.winner == "blue"
						wins +=1
					end
				elsif i.redTeam[counter] == championId
					matches +=1
					if i.winner == "red"
						wins +=1
					end
				end
				counter +=1
			end
		end

		return [to_chN(championId), wins, matches]
	end

	def championWinrate(championNames)
		matches = Array.new(championNames.length) { [0, 0, 0] }
		championNames.each_with_index do | champion, index|
			matches[index][0] = to_chI(champion)
			matches[index] = getWinsByChampion(matches[index][0])
		end
		
		if matches[0][0] != nil
			return matches
		else
			puts "Unknown championName" 
		end
	end
end