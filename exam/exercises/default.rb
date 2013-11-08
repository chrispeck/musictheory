require 'erb' #templating

class Default
	def initialize (params={})
		@type = params[:type] || "Unspecified Exercise Type"
		@items = params[:items] || 1
	end

	def generate
	end

	def ly (answer_key = false)
		template = ERB.new IO.read File.expand_path("../default.ly.erb",__FILE__)
		template.result(binding)
	end
end
