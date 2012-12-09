require 'active_support/core_ext/enumerable.rb' #for array.sum

pulses_per_beat = 3
beats_per_bar = 2
pulses_per_bar = pulses_per_beat * beats_per_bar
bars_per_exercise = 6
beats_per_exercise = bars_per_exercise * beats_per_bar

possible_beats = [
	[3],
	[2,1],
	[1,2],
	[1,1,1]
]

ly_notes_by_value = { 
	1 => "c8",
	2 => "c4",
	3 => "c4.",
	4 => "c2",
	5 => "c2~c8",
	6 => "c2.",
	7 => "c4.~c2"

}
possible_values = [1, 2, 3, 4]

ly_notes_with_ties = "" 
ly_notes_no_ties = "" 
values_with_ties = []
values_no_ties = []

beats_per_exercise.times do #12 beats in 6-8 would be 6 bars


	#values_this_beat = possible_beats.shuffle.first

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
		#but only if that would result in one of the allowed/possible note values

=begin
		puts values_with_ties.to_s
		puts values_no_ties.to_s
		puts
		puts values_this_beat.to_s
		puts values_this_beat_no_ties.to_s
		puts
		puts
=end

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

	#ly_notes_with_ties += " | " if values_with_ties.sum % pulses_per_bar == 0

end

values_no_ties.each do |note_value|
	ly_notes_no_ties += ly_notes_by_value[note_value] + " "
end

puts "%" + values_with_ties.to_s
puts "rhythms_with_ties = \\relative c' { " + ly_notes_with_ties + '\\bar "|." }'

puts "%" + values_no_ties.to_s
puts "rhythms_no_ties = \\relative c' { " + ly_notes_no_ties + '\\bar "|." }'
