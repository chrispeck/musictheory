class Scales < Exercise
	def initialize (params={})
		@items = params[:items] || 1
		@scale = params[:scale] || "major"

		# this was originally the possible keys for major scales
		# do i need a separate list for each kind of scale?
		@possible_keys = [
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
