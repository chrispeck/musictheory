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

\paper {
	indent = #0
	%ragged-right = ##t
	ragged-bottom = ##t
}

\markup{
	\wordwrap { 1. Re-write the rhythm in the given time signature. Use ties for note values that would cross beats or barlines. Beam notes appropriately for the time signature. 6 points each.}
}
<% rhythms.each do |rhythm| %>
\new Staff \relative c' {
	\override Score.BarNumber #'stencil = ##f
	\clef percussion
	
	\override Staff.TimeSignature #'stencil = ##f

	\override Staff.BarLine #'stencil = ##f
	\autoBeamOff
	<%= rhythm['no_ties'] %>
}
	<% if !answer_key %>
\new Staff \relative c' { 
	\clef percussion

	\autoBeamOff

	\override Score.BarNumber #'stencil = ##f
	\override Staff.BarLine #'stencil = ##f
	\override NoteHead #'transparent = ##t
	\override Stem #'transparent = ##t
	\override Flag #'transparent = ##t
	\override Dots #'transparent = ##t
	\override Tie #'transparent = ##t
	<%= rhythm['with_ties'] %>
}
	<% elsif answer_key %>
\new Staff \relative c' {
	\clef percussion
	<%= rhythm['with_ties'] %>
}
	<% end %>
<% end %>

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
