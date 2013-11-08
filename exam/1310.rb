require 'erb' #templating
require 'active_support/core_ext/enumerable.rb' #for array.sum
require 'require_all'

#load class definitions for individual exercise types
require_rel 'exercises/*.rb'

class TheoryExam
	def initialize(params = {})
		@exercises = []
		@title = params[:title] || "My Exam"
		@form_count = params[:forms] || 1
	end

	def addExercise(params = {})
		class_name = params[:type].capitalize
		if class_exists?(class_name)
			@exercises.push eval(class_name).new(params)
			puts "Success: " + class_name + " created!"
		else
			@exercises.push Default.new(params)
			puts "Whoops! No exercise by the name of '" + class_name + "'" 
		end
	end

	def generate()

		# generate and assemble ly markup for exercises

		filename = "my_exam"
		template = ERB.new IO.read File.expand_path("../1310.ly.erb",__FILE__)

		output = File.open 'exams/' + filename + ".ly", 'w'
		output << template.result(binding)
		#output << ly
		puts "writing " + filename
		output.close

		puts "compiling " + filename + " with LilyPond"
		puts %x(lilypond -o exams/#{filename} exams/#{filename}.ly)

	end

	#http://stackoverflow.com/questions/1187089/how-do-i-check-if-a-class-already-exists-in-ruby
	def class_exists?(class_name)
		klass = Module.const_get(class_name)
		return klass.is_a?(Class)
	rescue NameError
		return false
	end

end

#if there's any shared functionality required by exercises, maybe this could be an Exercise module instead, which can then be included in individual exercise classes?
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
