require 'erb' #templating

class Default
	def initialize (params={})
		@type = params[:type] || "Unspecified Exercise Type"
		@items = params[:items] || 1
	end
	def ly
		#"No generator definition for exercise type '" + @type + "' yet!"
		answer_key = true
		template = ERB.new IO.read File.expand_path("../default.ly.erb",__FILE__)
		template.result(binding)
	end
end
