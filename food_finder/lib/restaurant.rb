require 'support/number_helper'

class Restaurant

	include NumberHelper # including the NumberHelper as a Mixin

	@@filepath = nil    # class variable

	attr_accessor :name, :cuisine, :price

	#
	# Class Methods
	# 
	def self.filepath=(path=nil)                 # setter for the class variable
		@@filepath = File.join(APP_ROOT, path)
	end

	def self.file_exists?
		# class should know if the resturant file exists
		if @@filepath && File.exists?(@@filepath)
			return true
		else
			return false
		end
	end

	def self.file_usable?
		return false unless @@filepath  # better way to write the IF statements
		return false unless File.exists?(@@filepath)
		return false unless File.readable?(@@filepath)
		return false unless File.writable?(@@filepath)
		return true
	end

	def self.create_file
		# create the restaurant file
		File.open(@@filepath, "w") unless file_exists?
		return file_usable?
	end

	def self.saved_restaurants
		# read the restaurant file
		# return instances of the restaurant

		# We have to ask ourselves, do we want a fresh copy each
		# time or do we want to store the results in a variable?
		restaurants = []

		if file_usable?
			file = File.new(@@filepath, 'r')  # open file on read-mode

			file.each_line do |line|
				restaurants << Restaurant.new.import_line(line.chomp)
			end

			file.close
		end

		return restaurants
	end

	def self.build_using_questions
		args = {}

		print "Restaurant name: "
		args[:name] = gets.chomp.strip

		print "Cuisine type: "
		args[:cuisine] = gets.chomp.strip

		print "Average price: "
		args[:price] = gets.chomp.strip

		return self.new(args)
	end

	#
	# Instance Methods
	#

	def initialize(args={})
		@name    = args[:name]    || ""
		@cuisine = args[:cuisine] || ""
		@price   = args[:price]   || ""
	end

	def import_line(line)
		line_array = line.split("\t")
		@name, @cuisine, @price = line_array     # This is an array without brackets
		return self
	end

	def save
		return false unless Restaurant.file_usable?
		File.open(@@filepath, 'a') do |file|
			file.puts "#{[@name, @cuisine, @price].join("\t")}\n"
		end
		return true	
	end

	def formatted_price
		number_to_currency(@price)
	end
end