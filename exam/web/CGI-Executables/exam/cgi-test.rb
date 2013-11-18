#!/usr/bin/ruby -w                                                                                                           

# Get the form data
require 'cgi'
cgi = CGI.new
form_text = cgi['text']

# Append to the file
path = "/var/tmp/some.txt"
File.open(path,"a"){ |file| file.puts(form_text) }

# Send the HTML response
puts cgi.header  # content type 'text/html'
puts "<html><head><title>Doom!</title></head><body>"
puts "<h1>File Written</h1>"
puts "<p>I wrote #{path.inspect} with the contents:</p>"
puts "<pre>#{form_text.inspect}</pre>"
puts "</body></html>"
