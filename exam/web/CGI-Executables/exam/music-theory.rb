#!/usr/bin/ruby -w                                                                                                           
#http://localhost/cgi-bin/exam/music-theory.rb

#problem may involve getting the right modules installed in the apache module version or ruby?
#load "1310.rb"

# Get the form data
require 'cgi'
cgi = CGI.new

# Send the HTML response
puts cgi.header  # content type 'text/html'
puts "<html><head><title>Doom!</title></head><body>"
puts "<h1>Hopefully Creating Exam?</h1>"
puts "<p>Exam Name: #{cgi['name']}</p>"
puts "<p>Ex. Type: #{cgi['type']}</p>"
puts "<p>Ex. Item Count: #{cgi['items']}</p>"
puts "</body></html>"

=begin
exam = TheoryExam.new(
	:title => cgi['name'],
	:forms => 2
)

exam.addExercise(
	:type => cgi['type'],
	:items => cgi['items']
)

exam.compile

=end
