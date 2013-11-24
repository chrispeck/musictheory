require 'sinatra'
load '1310.rb'

get '/' do #form for user to enter options
	erb :index
end
post '/' do #generate exam on post

	@exercises = {}
	params.keys.each do |param|
		input = params[param]
		param_arr = param.split("_")
		case param_arr[0]
		when 'name'
			@name = input
		when 'ex' #parse param names from form field names ie "ex_2_scale" etc
			if @exercises[param_arr[1]].nil?
				@exercises[param_arr[1]] = {}
			end
			@exercises[param_arr[1]][param_arr[2]] = input
		else
		end
	end
	@exam = TheoryExam.new(
		:title => @name,
		:forms => 1 #each form of the exam will have different randomized items in each exercise
	)
	@exercises.keys.each do |num|
		ex = @exercises[num]
		@exam.addExercise(
			:type => ex["type"],
			:items => ex["items"].to_i 
		)
	end
	@exam.compile

	erb :response
end
