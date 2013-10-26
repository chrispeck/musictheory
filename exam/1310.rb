class TheoryExam
	def initialize(params = {})
		@exercises = []
		@title = params[:title] || "My Exam"
		@form_count = params[:forms] || 1
		puts "New Exam: " + @title + "!"
	end
	
	def addExercise(params = {})
		@exercises.push Exercise.new(params)
	end

	def generate()
		n = 0 
		@exercises.each do |ex|
			puts (n+=1).to_s + ": " + ex.type
		end
	end

end

class Exercise

	attr_accessor :type

	def initialize(params = {})
		@type = params[:type] || "default"
		#puts "New Exercise of type: " + @type + "!"
	end
end
