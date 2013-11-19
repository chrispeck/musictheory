class Triads < Exercise
	def initialize (params={})
		super(params)

		@triad_types = {
			"I" => %w(c e g),
			"I 6" => %w(e g c),
			"I 6 4" => %w(g c e),
			"ii" => %w(d f a),
			"ii 6" => %w(f a d),
			"ii 6 4" => %w(a d f),
			"iii" => %w(e g b),
			"iii 6" => %w(g b e),
			"iii 6 4" => %w(b e g),
			"IV" => %w(f a c),
			"IV 6" => %w(a c f),
			"IV 6 4" => %w(c f a),
			"V 7" => %w(g b d f),
			"V 5 6" => %w(b d f g),
			"V 4 3" => %w(d f g b),
			"V 2" => %w(f g b d),
			"vi" => %w(a c e),
			"vi 6" => %w(c e a),
			"vi 6 4" => %w(e a c),
			"vii o" => %w(b d f),
			"vii o 6" => %w(d f b),
			"vii o 6 4" => %w(f b d),
		}
	end

	def generate 
		@triads = []
		if @items <= @triad_types.length
			#for small number of exercises, no repetition
			@triads = @triad_types.keys.shuffle.slice 0..@items
		else #otherwise, simple random with replacement
			@items.times do
				@triads.push @triad_types.keys.shuffle.pop
			end
		end
	end
end

