\version "2.16.1" 
\language "english"

\header {
	title = "<%= title %>" 
	<% if answer_key %>
	subtitle = "answer key"
	<% else %>
	subtitle = "please use a pencil"
	<% end %>
}

\markup {
	\wordwrap { 2. Write each major scale starting from the given tonic. Use the appropriate key signature, not accidentals. 2 points each. }
}

<% 
	clefs = ex2_clefs.clone
	ex2_keys.each do |this_key| 
		key_name = this_key.first 
		tonic = this_key.last 

		clef = clefs.shift

		#make sure we're in the right octave for the clef
		if clef=="treble"
			starting_note = "c'" 
		elsif clef=="bass"
			starting_note = "e," 
		end
%>

\score {
	\transpose c <%=tonic%> \new Staff {

		% no time sig or barlines on either exam or key
		\override Staff.BarLine #'stencil = ##f
		\override Staff.TimeSignature #'stencil = ##f

		<% if !answer_key %>
		% no key signature on exam
		\override Staff.KeySignature #'transparent = ##t
		<% end %>

		\clef <%=clef%> 
		\key c \major
		\mark "<%=key_name%> major"

		\relative <%=starting_note%> { 

			c?1 %first note visible as an example on both exam and key 

			<% if !answer_key %>
			\hideNotes
			<% end %>

			d e f g a b c 
		}
	}
}
<%	end %>
