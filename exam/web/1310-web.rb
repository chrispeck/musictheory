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
		when 'forms'
			@forms = input.to_i
		when 'ex' #parse param names from form field names ie "ex_2_scale" etc
			if @exercises[param_arr[1]].nil?
				@exercises[param_arr[1]] = {}
			end
			@exercises[param_arr[1]][param_arr[2]] = input
		else
		end
	end
	@exam = TheoryExam.new(
		"title" => @name,
		"forms" => @forms #number of randomized forms of exam
	)
	@exercises.keys.each do |num|
		@exam.addExercise(@exercises[num])
	end
	@exam.compile

	erb :response
end
