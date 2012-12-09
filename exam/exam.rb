require 'erb' #templating

title = "MUSI 1310 Practice Final Exam"
base_name = "1310-final-practice"
exam_suffix = "-exam"
key_suffix = "-key"

major_keys = [
	[ 'Gb', 'gf' ],
	[ 'Db', 'df' ],
	[ 'Ab', 'af' ],
	[ 'Eb', 'ef' ],
	[ 'Bb', 'bf' ],
	[ 'D', 'd' ],
	[ 'A', 'a' ],
	[ 'E', 'e' ],
	[ 'B', 'b' ],
	[ 'F#', 'fs'] 
]

#choose five keys for major scale question
ex2_keys = major_keys.shuffle.slice 0..4
ex2_clefs = %w(treble treble bass bass bass).shuffle!

[false, true].each do |answer_key|

	template = ERB.new IO.read "exam-template.rb"

	if answer_key 
		filename = base_name + key_suffix
	else
		filename = base_name + exam_suffix
	end

	output = File.open 'exams/' + filename + ".ly", 'w'
	output << template.result(binding)
	puts "writing " + filename
	output.close

	puts "compiling " + filename + " with LilyPond"
	puts %x(lilypond -o exams/#{filename} exams/#{filename}.ly)

end
