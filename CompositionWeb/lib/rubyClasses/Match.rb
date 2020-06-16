class Match
	attr_reader :matchId, :matchDate, :blueTeam, :redTeam, :winner

	def initialize(id, date, blue, red, win)
		@matchId = id
		@matchDate = date
		@blueTeam = blue
		@redTeam = red
		@winner = win
	end
end