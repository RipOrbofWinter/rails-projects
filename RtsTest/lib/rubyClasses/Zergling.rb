require_relative 'Unit'

class Zergling < Unit
	def initialize()
		@name = "Zergling"
		@uuid = SecureRandom.uuid
		@attributes = ["Biological", "Light"]
        @cost = [50, 0]
        @health = 35
        @shield = 0
        @attackDamage = 5
        @multipleAttacks = false
        @healthArmor = 0
        @shieldArmor = 0
	end

end
	