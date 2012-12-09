# ___ is the submediant of the G major scale.
# F# is the supertonic of the F# major scale.
# as in Duckworth p112-113

# G is the dominant of the ____ harmonic minor scale."
# as in Duckworth p198

ex_count = 100 #how many exercises?

puts "Scale Degree Name Fill-in-the-blank Practice"

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

questions = []
answers = []
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

	answers.push "#{ex}. #{note} is the #{name} of the #{tonic} #{mode} scale." 

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

	questions.push "#{ex}. #{note} is the #{name} of the #{tonic} #{mode} scale." 

	ex += 1

end

questions.each do |q|
	puts q
end

puts "__________________________________________________________________________"

answers.each do |a|
	puts a
end

	
	

