require 'sinatra'
load '1310.rb'

get '/' do #form for user to enter options
	erb :index
end
post '/' do #generate exam on post

	@exam = TheoryExam.new(
		:title => params[:name],
		:forms => 1 #each form of the exam will have different randomized items in each exercise
	)
	@exam.addExercise(
		:type => params[:type],
		:items => params[:items].to_i 
	)
	@exam.compile

	erb :response
end
