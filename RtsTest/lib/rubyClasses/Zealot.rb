require_relative 'Unit'

class Zealot < Unit
	def initialize()
		@name = "Zealot"
		@uuid = SecureRandom.uuid
		@attributes = ["Biological", "Light"]
        @cost = [100, 0]
        @health = 100
        @shield = 50
        @attackDamage = 8
        @multipleAttacks = true
        @healthArmor = 1
        @shieldArmor = 0
	end
end