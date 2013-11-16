class Degrees < Exercise
	def initialize (params={})
		@items = params[:items] || 1
		@scale = params[:scale] || "major"

	end

	def generate #generate new form of exercise 

		# ___ is the submediant of the G major scale.
		# F# is the supertonic of the F# major scale.
		# as in Duckworth p112-113

		# G is the dominant of the ____ harmonic minor scale."
		# as in Duckworth p198

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

		@degree_items = []
		ex = 1 #exercise number

		@items.times do
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

			#at random, replace one element of the phrase with a blank
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
			@degree_items.push this_item
		end
	end
end
