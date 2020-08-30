#Load uuid library
require 'securerandom'

class Unit
	attr_accessor :attackDamage, :attackSpeed, :health, :shield, :healthArmor, :shieldArmor
	attr_reader :name, :uuid, :attributes, :cost, :multipleAttacks

	def error01()
		raise "Error 01: dead unit #{@name} #{@uuid} has shield points"
	end

	def attack(receiver)
		puts "#{@name} attacked #{receiver.name}"
        receiver.receiveDamage(@attackDamage)
        if @multipleAttacks == true
        	receiver.receiveDamage(@attackDamage)
        end
	end

    def receiveDamage(damage_received)
        if @shield > 0 && @health > 0
            @shield -= damage_received
            if @shield < 0
                @shield = 0
            	return false
        	end
        elsif @shield <= 0 && @health > 0
        	# Deal damage and check if unit died.
	        @health -= damage_received
	        if @health <= 0
	        	puts
	            puts "#{@name} #{@uuid} has been defeated"
	            return true
	        elsif @health > 0
	            puts "#{@name} #{@uuid} has #{@health} health remaining"
	            return false
	        end
	    elsif @shield > 0 && @health <= 0
	    	error01()
	    elsif @health <= 0 && @shield <= 0
	    	return true
	    end
    end
end