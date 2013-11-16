load "1310.rb"

exam = TheoryExam.new(
	:title => "My Final Exam",
	:forms => 2 #each form of the exam will have different randomized items in each exercise
)

=begin
exam.addExercise(
	:type => "rhythms",
	:bars => 6,	#number of bars in each item
	:items => 2
)

exam.addExercise(
	:type => "rhythms",
	:bars => 4,
	:items => 3
)

exam.addExercise(
	:type => "scales",
	:scale => "major",
	:items => 5
)

exam.addExercise(
	:type => "degrees",
	:items => 10
)

=end

exam.addExercise(
	:type => "intervals",
	:items => 10
)

=begin

exam.addExercise(
	:type => "scales",
	:scale => "melodic minor",
	:items => 2
)

exam.addExercise(
	:type => "scales",
	:scale => "harmonic minor",
	:items => 2
)

exam.addExercise(
	:type => "scales",
	:scale => "natural minor",
	:items => 2
)

exam.addExercise(
	:type => "scales",
	:scale => "minor pentatonic",
	:items => 2
)

exam.addExercise(
	:type => "scales",
	:scale => "major pentatonic",
	:items => 2
)

exam.addExercise(
	:type => "triads",
	:items => 10
)

exam.addExercise(
	:type => "analysis",
	:name => "winchester" #reads 2 files: winchester.ly and winchester-key.ly
)
=end

exam.compile
