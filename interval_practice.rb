ex_count = 100 #how many interval exercises?

print <<HEADER
\\version "2.16.1"

\\header {
	title = "Identify These F**king Intervals"
	subtitle = "What? You've got something better to do? I didn't think so."
}

HEADER

note_names = %w(a b c d e f g)

degrees_by_note = { 
	'a' => 0,
	'b' => 1,
	'c' => 2,
	'd' => 3,
	'e' => 4,
	'f' => 5,
	'g' => 6
}

bass_notes_sharp = %w(
	c, cis, d, dis, e, f, fis, g, gis, a, ais, b,
	c cis d dis e f fis g gis a ais b 
	c' cis' d' dis' e' f' fis'	
)

bass_notes_flat = %w(
	c, des, d, ees, e, f, ges, g, aes, a, bes, b,
	c des d ees e f ges g aes a bes b
	c' des' d' ees' e' f'
)

treble_notes_sharp = %w(
	e f fis g gis a ais b 
	c' cis' d' dis' e' f' fis' g' gis' a' ais' b' 
	c'' cis'' d'' dis'' e'' f'' fis'' g'' gis'' a'' ais'' b'' 
	c''' cis''' d''' dis'''
)

treble_notes_flat = %w(
	e f ges g aes a bes b
	c' des' d' ees' e' f' ges' g' aes' a' bes' b'
	c'' des'' d'' ees'' e'' f'' ges'' g'' aes'' a'' bes'' b''
	c''' des''' d'''
)

notes_by_clef = {
	'bass' => [bass_notes_sharp, bass_notes_flat],
	'treble' => [treble_notes_sharp, treble_notes_flat]
}

=begin
puts "%note list sizes:"
notes_by_clef.each do |clef, note_lists|
	note_lists.each do |notes|
		puts "%size - #{notes.size}"
	end
end
=end

puts '{'
interval_classes = [] #print ic's as lyrics
interval_names = [] #for answer key

ex_count.times do

	clef = notes_by_clef.keys.shuffle.pop #bass or treble?
	puts "\t\\clef #{clef}"

	notes = notes_by_clef[clef].shuffle.pop #sharps or flats?

	print "\t" 

	ic = rand(25) - 12 #plus or minus an octave, including unison
	interval_classes.push ic

	p1 = rand(notes.size - 25) + 12
	p2 = p1 + ic  

	n1 = notes[p1]; n2 = notes[p2]
	
	puts "#{n1}2 #{n2}2" 
	puts

	#calculate interval name
	note_name1 = n1.slice(0); note_name2 = n2.slice(0)
	degree1 = degrees_by_note[note_name1]; degree2 = degrees_by_note[note_name2]

	possible_interval_sizes = [
		(degree1 - degree2).abs,
		(degree1 + 7 - degree2).abs,
		(degree1 - ( degree2 + 7) ).abs
	]

	interval_size = possible_interval_sizes.min

	n = "" #interval name

	ic = ic.abs

	case interval_size
	when 0 #unison or octave
		case ic
		when 0 
			n = "PU" 
		when 1 
			n = "AU"
		when 11 
			n = "d8"
		when 12 
			n = "P8"
		else 
			n = "U/8?"
		end
	when 1 #second or seventh
		case ic
		when 0 
			n = "d2"
		when 1 
			n = "m2"
		when 2 
			n = "M2"
		when 3
			n = "A2"
		when 9 
			n = "d7"
		when 10 
			n = "m7"
		when 11 
			n = "M7"
		when 12 
			n = "A7"
		else 
			n = "2/7?"
		end
	when 2 #third or sixth
		case ic
		when 2 
			n = "d3"
		when 3 
			n = "m3"
		when 4 
			n = "M3"
		when 5 
			n = "A3"
		when 7 
			n = "d6"
		when 8 
			n = "m6"
		when 9 
			n = "M6"
		when 10 
			n = "A6"
		else 
			n = "3/6?"
		end
	when 3 #forth or fifth
		case ic
		when 4 
			n = "d4"
		when 5 
			n = "P4"
		when 6 
			n = "TT" #edge case. no way to disentangle the complementaries via the ic
		when 7 
			n = "P5"
		when 8 
			n = "A5"
		else 
			n = "4/5?"
		end
	else
		n = "?"
	end

	interval_names.push n 
		

end

puts '}'

puts "\\addlyrics {"
interval_names.each do |ic|
	puts "\t\"#{ic}\" \" \"" #extra blank lyric for the second note
end

puts '}'

