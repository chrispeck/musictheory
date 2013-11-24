require 'erb' #templating
require 'active_support/core_ext/enumerable.rb' #for array.sum
require 'require_all' #to allow each exercise def to live in its own file
require 'securerandom' #to generate uuid


class TheoryExam
	def initialize(params = {})
		@exercises = []
		@title = params[:title] || "My Exam"
		@form_count = params[:forms] || 1

		@name = @title.downcase.gsub("\s","_")
	end

	def addExercise(params = {})
		class_name = params["type"].to_s.capitalize
		if class_exists?(class_name)
			@exercises.push eval(class_name).new(params)
			puts "Success: " + class_name + " created!"
		else
			@exercises.push Default.new(params)
			#puts "Whoops! No exercise by the name of '" + class_name + "'" 
		end
	end

	def compile 
		#@render_path = 'public/exams/' + SecureRandom.uuid + '/'
		@uuid = SecureRandom.uuid

		#url that user will download generated files from
		@archive_url = "exams/#{@uuid}/#{@name}.tgz"

		#randomly generated path for this exam
		@base_render_path = "public/exams/#{@uuid}/"
		puts %x(mkdir #{@base_render_path})

		#path for generating ly and pdf files that will be archived for download
		@render_path = @base_render_path + "#{@name}/"
		puts %x(mkdir #{@render_path})

		# generate exercises and compile pdf for each exam form
		@form_count.times do |form_number|
			form_number = form_number + 1 #start counting with 1

			@exercises.each do |ex| 
				ex.generate
			end

			[false, true].each do |answer_key| #one pass for the exam, another for the key
				filename = @name 
				filename = filename + "_form_" + form_number.to_s if @form_count > 1
				filename = filename + "-key" if answer_key
				template = ERB.new IO.read File.expand_path("../1310.ly.erb",__FILE__)

				output = File.open @render_path + filename + ".ly", 'w'
				output << template.result(binding)
				#output << ly
				puts "writing " + filename
				output.close

				puts "compiling " + filename + " with LilyPond"
				puts %x(lilypond -o #{@render_path}#{filename} #{@render_path}#{filename}.ly)
			end
		end

		#make an archive of all generated files
		old_pwd = Dir.pwd #revert to pwd after zipping...this was messing up Sinatra
		Dir.chdir(@base_render_path)
		puts %x(tar -cvzf #{@name}.tgz #{@name})
		Dir.chdir(old_pwd)

	end

	def get_url
		@archive_url
	end

	#http://stackoverflow.com/questions/1187089/how-do-i-check-if-a-class-already-exists-in-ruby
	def class_exists?(class_name)
		klass = Module.const_get(class_name)
		return klass.is_a?(Class)
	rescue NameError
		return false
	end

end

#if there's any shared functionality required by exercises, maybe this could be an Exercise module instead, which can then be included in individual exercise classes? Or maybe they should inherit from this class?
class Exercise
	def initialize (params={})
		@type = params["type"] || "Unspecified Exercise Type"
		@items = params["items"].to_i || 1
	end

	def generate
	end

	def ly(answer_key = false)
		#is there a better way to do this? should my templates be in a different place?
		template = ERB.new IO.read File.expand_path("../exercises/" + @type + ".ly.erb",__FILE__)
		template.result(binding)
	end
end

#load class definitions for individual exercise types
require_rel 'exercises/*.rb'
