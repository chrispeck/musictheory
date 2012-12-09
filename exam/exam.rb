require 'erb' #templating
require 'active_support/core_ext/enumerable.rb' #for array.sum

title = "MUSI 1310 Practice Final Exam"
base_name = "1310-final-practice"
exam_suffix = "-exam"
key_suffix = "-key"

#######################
# ex1 - rhythms

bars_per_exercise = 6

meters = {
	'6/8' =>	{ 
		'pulses_per_beat' => 6,
		'beats_per_bar' => 2,
		'possible_values' => [2,4,6],
	},
	'2/4' => {
		'pulses_per_beat' => 4,
		'beats_per_bar' => 2,
		'possible_values' => [1,2,2,4,4], #repeat values to make them more likely
	},
	'3/4' => {
		'pulses_per_beat' => 4,
		'beats_per_bar' => 3,
		'possible_values' => [1,2,2,4,4], #repeat values to make them more likely
	},
	'4/4' => {
		'pulses_per_beat' => 4,
		'beats_per_bar' => 4,
		'possible_values' => [2,4], #repeat values to make them more likely
	},
}

ly_notes_by_value = { 
	1 => "c16",
	2 => "c8",
	3 => "c8.",
	4 => "c4",
	5 => "c4~c16",
	6 => "c4.",
	7 => "c4.~c6",
	8 => "c2",
	9 => "c2~c16",
	10 => "c2~c8",
	11 => "c2~c8.",
	12 => "c2.",
	13 => "c2.~c16",
	14 => "c2.~c8",
	15 => "c2.~c8.",
	16 => "c1"
}
rhythms = []

meters.keys.shuffle.each do |time|
	pulses_per_beat = meters[time]['pulses_per_beat']
	beats_per_bar = meters[time]['beats_per_bar']
	pulses_per_bar = pulses_per_beat * beats_per_bar
	beats_per_exercise = bars_per_exercise * beats_per_bar

	possible_values = meters[time]['possible_values'] 



	ly_notes_with_ties = "" 
	ly_notes_no_ties = "" 
	values_with_ties = []
	values_no_ties = []

	beats_per_exercise.times do

		values_this_beat = [] #rhythmic values for this beat

		# fill the beat with notes
		until values_this_beat.sum == pulses_per_beat
			values_this_beat.push possible_values.shuffle.pop
			values_this_beat.pop if values_this_beat.sum > pulses_per_beat
		end

		#add ties between last note of prev beat and first note of this one?
		if ( ( values_no_ties.length > 0 ) and ( rand(100) < 30) ) #change to maybe 30?

			#need to explicitly creat new array, otherwise new var will simply be a reference
			values_this_beat_no_ties = Array.new values_this_beat

			#add the last note of the prev beat to the first note of this one 
			#checking value of previous note first to make sure the resulting value isn't too large
			if possible_values.include? values_no_ties.last #make sure not to tie two in a row
				values_no_ties.push values_no_ties.pop + values_this_beat_no_ties.shift
				values_no_ties.concat values_this_beat_no_ties
				ly_notes_with_ties += "~" #tie symbol for ly
			else
				values_no_ties.concat values_this_beat
			end
		else	
			values_no_ties.concat values_this_beat
		end

		values_with_ties.concat values_this_beat

		values_this_beat.each do |note_value|
			ly_notes_with_ties += ly_notes_by_value[note_value] + " " 
		end

	end

	values_no_ties.each do |note_value|
		ly_notes_no_ties += ly_notes_by_value[note_value] + " "
	end

	ly_expr_with_ties = "\\relative c' { \\time #{time}" + ly_notes_with_ties + '\\bar "|." }'
	ly_expr_no_ties = "\\relative c' { \\time #{time}" + ly_notes_no_ties + '\\bar "|." }'
	this_rhythm = {
		'with_ties' => ly_expr_with_ties,
		'no_ties' => ly_expr_no_ties
	}
	rhythms.push this_rhythm

end

#######################
# ex2 - major scales

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

######################
# ex3 - note naming

# ___ is the submediant of the G major scale.
# F# is the supertonic of the F# major scale.
# as in Duckworth p112-113

# G is the dominant of the ____ harmonic minor scale."
# as in Duckworth p198

ex_count = 10 #how many exercises?


maj_scales = [
	%w{Cb Db Eb Fb Gb Ab Bb},
	%w{Gb Ab Bb Cb Db Eb F},
	%w{Db Eb F Gb Ab Bb C},
	%w{Ab Bb C Db Eb F G},
	%w{Eb F G Ab Bb C D},
	%w{Bb C D Eb F G A},
	%w{F G A Bb C D E},
	%w{C D E F G A B},
	%w{G A B C D E F#},
	%w{D E F# G A B C#}, 
	%w{A B C# D E F# G#},
	%w{E F# G# A B C# D#},
	%w{B C# D# E F# G# A#},
	%w[F# G# A# B C# D# E#],
	%w[C# D# E# F# G# A# B#],
]

min_scales = [
	%w{Ab Bb Cb Db Eb Fb G},
	%w{Eb F Gb Ab Bb Cb D},
	%w{Bb C Db Eb F Gb A},
	%w{F G Ab Bb C Db E},
	%w{C D Eb F G Ab B},
	%w{G A Bb C D Eb F#},
	%w{D E F G A Bb C#},
	%w{A B C D E F G#},
	%w{E F# G A B C D#},
	%w{B C# D E F# G A#}, 
	%w{F# G# A B C# D E#},
	%w{C# D# E F# G# A B#},
	%w{G# A# B C# D# E F+},
	%w[D# E# F# G# A# B C+],
	%w[A# B# C# D# E# F# G+],
]

degree_names = ['tonic', 'supertonic', 'mediant', 'subdominant', 'dominant', 'submediant', 'leading tone']

ex3_items = []
ex = 1 #exercise number

ex_count.times do
	if rand(2)==1
		mode = "major"
		scale = maj_scales.shuffle.pop
	else
		mode = "harmonic minor"
		scale = min_scales.shuffle.pop
	end
		
	degree = rand(7)
	note = scale[degree]
	name = degree_names[degree]
	tonic = scale[0]

	this_answer = "#{ex}. #{note} is the #{name} of the #{tonic} #{mode} scale." 

	case rand(3)
	when 0
		note = "___"
	when 1
		name = "_____________"
	when 2
		tonic = "___"
	else
		abort("Error.")
	end

	this_question = "#{ex}. #{note} is the #{name} of the #{tonic} #{mode} scale." 

	ex += 1

	this_item = {
		'question' => this_question,
		'answer' => this_answer
	}
	ex3_items.push this_item
end

########################
# ex 4 Interval ID

ex_count = 10

intervals_from_c = {
	'PU' => 'c',
	'AU' => 'cs',
	'd2' => 'dff',
	'm2' => 'df',
	'M2' => 'd',
	'A2' => 'ds',
	'd3' => 'eff',
	'm3' => 'ef',
	'M3' => 'e',
	'A3' => 'es',
	'd4' => 'ff',
	'P4' => 'f',
	'A4' => 'fs',
	'd5' => "gf'",
	'P5' => "g'",
	'A5' => "gs'",
	'd6' => "aff'",
	'm6' => "af'",
	'M6' => "a'",
	'A6' => "as'",
	'd7' => "bff'",
	'm7' => "bf'",
	'M7' => "b'",
	'A7' => "bs'",
	'd8' => "cf'",
	'P8' => "c'",
}

my_intervals = intervals_from_c.keys.shuffle.slice 1..10
ex4 = []

my_intervals.each do |name|
	note1 = "c"
	note2 = intervals_from_c[name]
	ex = {'note1' => note1, 'note2' => note2, 'name' => name}
	ex4.push ex
end
	

#write files for exam and answer key
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
