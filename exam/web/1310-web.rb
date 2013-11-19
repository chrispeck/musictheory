require 'sinatra'
load '1310.rb'

get '/' do #form for user to enter options
	erb :index
end
post '/' do #generate exam on post
	exam = TheoryExam.new(
		:title => "My Final Exam",
		:forms => 2 #each form of the exam will have different randomized items in each exercise
	)
	exam.addExercise(
		:type => "rhythms",
		:bars => 6,	#number of bars in each item
		:items => 2
	)
	exam.compile

	'Exam Generation Complete!'
end
