class Calculator

	def isNegative(quantumState)
		if quantumState < 0
			return 1
		elsif quantumState >= 0
			return 0
		end	
	end

	def toPositive(negativeInteger)
		negativeInteger = 0 - negativeInteger
	end


end