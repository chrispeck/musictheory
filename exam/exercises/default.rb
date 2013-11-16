class Default < Exercise
	def initialize (params={})
		@type = params[:type] || "Unspecified Exercise Type"
		@items = params[:items] || 1
	end

	def generate #generate exercise for each exam form
	end
end
