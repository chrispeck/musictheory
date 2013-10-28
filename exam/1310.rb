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

		# generate and assemply ly markup for exercises
		# should actually use a template here to add header and footer
		# as well as perhaps a number for each ex?

		ly = "" #exam in lilypond markup
		@exercises.each do |ex|
			ly = ly + ex.ly
		end

		filename = "my_exam"

		output = File.open 'exams/' + filename + ".ly", 'w'
		#output << template.result(binding)
		output << ly
		puts "writing " + filename
		output.close

		puts "compiling " + filename + " with LilyPond"
		puts %x(lilypond -o exams/#{filename} exams/#{filename}.ly)

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
