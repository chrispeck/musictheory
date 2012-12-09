require 'active_support/core_ext/enumerable.rb' #for array.sum

bars_per_exercise = 6

meters = {
	'6/8' =>	{ 
		'pulses_per_beat' => 6,
		'beats_per_bar' => 2,
		'possible_values' => [2,4,6],
	},
	'4/4' => {
		'pulses_per_beat' => 4,
		'beats_per_bar' => 4,
		'possible_values' => [1,2,2,4,4], #repeat values to make them more likely
	},
	'3/4' => {
		'pulses_per_beat' => 4,
		'beats_per_bar' => 4,
		'possible_values' => [1,2,2,4,4], #repeat values to make them more likely
	},
}

time = '3/4'

pulses_per_beat = meters[time]['pulses_per_beat']
beats_per_bar = meters[time]['beats_per_bar']
pulses_per_bar = pulses_per_beat * beats_per_bar
beats_per_exercise = bars_per_exercise * beats_per_bar

possible_values = meters[time]['possible_values'] 
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

puts "%" + values_with_ties.to_s
puts "rhythms_with_ties = \\relative c' { \\time #{time}" + ly_notes_with_ties + '\\bar "|." }'

puts "%" + values_no_ties.to_s
puts "rhythms_no_ties = \\relative c' { \\time #{time}" + ly_notes_no_ties + '\\bar "|." }'
