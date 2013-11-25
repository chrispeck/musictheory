class Scales < Exercise
	def initialize (params={})
		super(params)
		@scale = params["scale"] || "major"

		# from 2 to 6 flats or sharps, major and minor keys
		possible_keys_major = [
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
		possible_keys_minor = [
			#[ 'a', 'a' ],

			#[ 'e', 'e' ],
			[ 'b', 'b' ],
			[ 'f#', 'fs' ],
			[ 'c#', 'cs' ],
			[ 'g#', 'gs' ],
			[ 'd#', 'ds' ],

			#[ 'd', 'd' ],
			[ 'g', 'g' ],
			[ 'c', 'c' ],
			[ 'f', 'f' ],
			[ 'bb', 'bf' ],
			[ 'eb', 'ef' ]
		]

		if @scale.include? "minor"
			@possible_keys = possible_keys_minor
		else
			@possible_keys = possible_keys_major
		end
	end

	def generate #generate new form of exercise 
		@clefs = []
		@keys = []

		@items.times do 
			@clefs.push %w(treble bass).shuffle.pop
			@keys.push @possible_keys.shuffle.pop
		end
	end
end
