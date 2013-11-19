class Intervals < Exercise
	def generate (answer_key = false)
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

		starting_notes = %w(c cs df d ds ef e f fs g gs af a as bf b)

		my_intervals = []
		@my_starting_notes = []

		if @items <= intervals_from_c.length
			#for small number of exercises, no repetition
			my_intervals = intervals_from_c.keys.shuffle.slice 1..@items
			@my_starting_notes = starting_notes.shuffle.slice 1..@items
		else #otherwise, simple random with replacement
			@items.times do
				my_intervals.push intervals_from_c.keys.shuffle.pop
				@my_starting_notes.push starting_notes.shuffle.pop
			end
		end
		@interval_items = []

		my_intervals.each do |name|
			note1 = "c"
			note2 = intervals_from_c[name]
			item = {'note1' => note1, 'note2' => note2, 'name' => name}
			@interval_items.push item 
		end
	end
end
