require 'erb' #templating
require 'active_support/core_ext/enumerable.rb' #for array.sum
require 'require_all'

require_rel 'exercises/*.rb'

class TheoryExam
	def initialize(params = {})
		@exercises = []
		@title = params[:title] || "My Exam"
		@form_count = params[:forms] || 1
	end

	def addExercise(params = {})
		@exercises.push Exercise.new(params)
	end

	def generate()
		n = 0 
		@exercises.each do |ex|
			puts ex.ly
		end
	end
end

class Exercise
	attr_accessor :type

	def initialize(params = {})
		@type = params[:type] || "default"
		@items = params[:type] || 1
		
		case params[:type]
		when "rhythms"
			@generator = Rhythms.new(params)
			puts "Success! Rhythm exercise generator instantiated!"
		else
			@generator = Default.new(params)
			puts "Warning: '" + params[:type] + "' is not a valid exercise type!"
		end
	end

	def ly
		@generator.ly	
	end

end
