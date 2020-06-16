class DataGrabber
	def initialize
		@key = "RGAPI-6c8d8e14-7823-4da6-bc0f-81ca72a79dce"
        @errorCounter = 0
	end

	def getMatch(matchId)
		url = "https://euw1.api.riotgames.com/lol/match/v4/matches/#{matchId}"
		headers = {
		 'X-Riot-Token': "#{@key}"
		}

		response = HTTParty.get(url, headers: headers)
		my_hash = JSON.parse(response.body)

        my_hash = testForError(my_hash)
		if my_hash != ""
            p my_hash["gameId"]
            date = Time.at(0, my_hash["gameCreation"].to_i, :millisecond).strftime("%d/%m/%Y %k:%M")
            blueTeam = Array.new()
            redTeam = Array.new()
            winner = ""
            i = 0
            while i < 10
                if i < 5
                    blueTeam.push(my_hash["participants"][i]["championId"])
                elsif i >= 5 && i < 10
                    redTeam.push(my_hash["participants"][i]["championId"])
                end
                i+=1
            end
            if my_hash["teams"][0]["win"] == "Win"
                winner = "blue"
            elsif my_hash["teams"][1]["win"] == "Win"
                winner = "red"
            else
                puts "No winner found; Rito games strikes again"
                return
            end
            game = Match.new(my_hash["gameId"], date, blueTeam, redTeam, winner) 
            return game
        else
            puts "\nAdding match aborted"
        end
	end

    def getManyMatch()
    end

    def getByLeague()
        @errorCounter = 0
        tiers = ["I", "II", "III", "IV"]
        games = Array.new()
            # get random user from specified elo
            url = "https://euw1.api.riotgames.com/lol/league/v4/entries/RANKED_FLEX_SR/PLATINUM/#{tiers[rand(0..3)]}?page=#{rand(1..10)}"
            headers = { 'X-Riot-Token': "#{@key}" }
            response = HTTParty.get(url, headers: headers)
            my_hash = JSON.parse(response.body)
            my_hash = testForError(my_hash)
            if my_hash == "" && @errorCounter < 3
                exit
            end
            my_hash = my_hash[rand(1..150)]["summonerId"]
            # get accountID for match history
            url = "https://euw1.api.riotgames.com/lol/summoner/v4/summoners/#{my_hash}"
            response = HTTParty.get(url, headers: headers)
            my_hash = JSON.parse(response.body)
            my_hash = testForError(my_hash)
            if my_hash == "" && @errorCounter < 3
                exit
            end
            my_hash = my_hash["accountId"]
            # get a match with the acount id
            url = "https://euw1.api.riotgames.com/lol/match/v4/matchlists/by-account/#{my_hash}?queue=440"
            response = HTTParty.get(url, headers: headers)
            my_hash = JSON.parse(response.body)
            my_hash = testForError(my_hash)
            if my_hash == "" && @errorCounter < 3
                exit
            end
            # loop through match history
            loopCounter = 1
            while loopCounter <= 7 do
                games.push(self.getMatch(my_hash["matches"][loopCounter]["gameId"]))
                loopCounter += 1
            end

        return games
    end

    def testForError(my_hash)
        begin
            if  my_hash["status"] != nil
                puts "\nError code #{my_hash["status"]["status_code"]}:"
                puts my_hash["status"]["message"]
                @errorCounter += 1
                my_hash = ""
            end
        rescue
            return my_hash
        end
        if @errorCounter >= 3
            exit
        end
        return my_hash
    end
end