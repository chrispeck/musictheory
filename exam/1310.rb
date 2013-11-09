require 'erb' #templating
require 'active_support/core_ext/enumerable.rb' #for array.sum
require 'require_all' #to allow each exercise def to live in its own file


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

	def compile 

		# generate exercises and compile pdf for each exam form
		@form_count.times do |form_number|
			form_number = form_number + 1 #start counting with 1

			@exercises.each do |ex| 
				ex.generate
			end

			[false, true].each do |answer_key| #one pass for the exam, another for the key
				filename = "my_exam"
				filename = filename + "_form_" + form_number.to_s if @form_count > 1
				filename = filename + "-key" if answer_key
				template = ERB.new IO.read File.expand_path("../1310.ly.erb",__FILE__)

				output = File.open 'exams/' + filename + ".ly", 'w'
				output << template.result(binding)
				#output << ly
				puts "writing " + filename
				output.close

				puts "compiling " + filename + " with LilyPond"
				puts %x(lilypond -o exams/#{filename} exams/#{filename}.ly)
			end
		end
	end

	#http://stackoverflow.com/questions/1187089/how-do-i-check-if-a-class-already-exists-in-ruby
	def class_exists?(class_name)
		klass = Module.const_get(class_name)
		return klass.is_a?(Class)
	rescue NameError
		return false
	end

end

#if there's any shared functionality required by exercises, maybe this could be an Exercise module instead, which can then be included in individual exercise classes? Or maybe they should inherit from this class?
class Exercise
	def ly(answer_key = false)
		#is there a better way to do this? should my templates be in a different place?
		my_name = self.class.to_s.downcase
		template = ERB.new IO.read File.expand_path("../exercises/" + my_name + ".ly.erb",__FILE__)
		template.result(binding)
	end
end

#load class definitions for individual exercise types
require_rel 'exercises/*.rb'
