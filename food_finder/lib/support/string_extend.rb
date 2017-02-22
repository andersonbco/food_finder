# This helper is  opening up core Ruby String class
# in order to add a new method to all Strings
class String

	# Ruby has a capitalizing method (used below) which
	# capitalizes the first letter of a String. But in 
	# order to capitalize the first letter of EVERY 
	# word we have to write our own.
	def titleize
		self.split(' ').collect {|word| word.capitalize}.join(" ")
	end

end