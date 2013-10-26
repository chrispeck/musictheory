require 'erb' #templating

class Default
	def initialize (params={})
		@type = params[:type] || "Unspecified Exercise Type"
		@items = params[:items] || 1
	end
	def ly
		"No generator definition for exercise type '" + @type + "' yet!"
	end
end
