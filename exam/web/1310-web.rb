require 'sinatra'
load '1310.rb'

get '/' do #form for user to enter options
	erb :index
end
post '/' do #generate exam on post
	exam = TheoryExam.new(
		:title => "my_web_exam",
		:forms => 1 #each form of the exam will have different randomized items in each exercise
	)
	exam.addExercise(
		:type => "rhythms",
		:bars => 6,	#number of bars in each item
		:items => 1 
	)
	exam.compile


	'Exam Generation Complete! <a href="' + exam.get_url + '">download (tgz archive)</a>'

end
