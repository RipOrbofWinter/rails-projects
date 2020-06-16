class MatchList
	attr_accessor :history
	def initialize
		@history = Array.new()
	end

# 	def printHistory(calculator, champion_options)
# 		puts "\nHere is a history of all saved matches: \n\n"
# 		@history.each do |i|
# 			# convert ids to name
# 			counter = 1;
# 			redChampions = ""
# 			blueChampions = ""
# 			while counter <=10
# 				if counter <=5
# 					blueChampions += "#{calculator.to_chN(i.blueTeam[counter-1])}, "
# 				else
# 					redChampions += "#{calculator.to_chN(i.redTeam[counter-6])}, "
# 				end
# 				counter +=1
# 			end
# 			multiline_string = """
# Match #{i.matchId}:
# Blue side champions are: #{blueChampions}
# VS
# Red side champions are: #{redChampions}
# The winning team is team #{i.winner}
# """
# 			puts multiline_string
# 		end
# 		puts "\n"
# 	end

	def history=(game)
		@history.push(game) 
	end
end