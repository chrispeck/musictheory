\version "2.16.1" 
\language "english"

\include "roman_numerals.ly"

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
	%between-system-padding = #2
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

\markup {
	\column {
		\wordwrap { 3. Fill in the blank with the appropriate note or scale degree name. 1 point each.}
		\line { "   " } %empty line for spacing
	<%
		ex3_items.each do |item|
			if answer_key
				item_text = item['answer']
			else 
				item_text = item['question']
			end
	%> 
		\line { "     <%= item_text %>" } %
	<% end %>
		\line { "   " } %another empty line
	}
}

\markup {
	\wordwrap { 4. Write a new note the given interval above the given note. 1 point each. }
}

\score {
	\relative c' {
		\clef treble
		\time 8/4
	<% 
		trans_notes = my_starting_notes.clone
		ex4.each do |ex|
			if answer_key
				name = ex['name']
			else
				name = '"   "'   
			end
	%>
		\mark "<%=ex['name']%>"

		\transpose c <%= trans_notes.shift %> \relative c' { 

		<%=ex['note1']%>!='1

		<% if !answer_key %> 
		\hideNotes 
		<% end %>

		<%=ex['note2']%>!1
}
		\unHideNotes
		\bar "||" 

	<% end %>
	}
}

\markup {
	\wordwrap { 5. Write each minor scale starting from the given tonic. Use the appropriate key signature with accidentals as needed. 2 points each. }
}

<% 
	clefs = ex5_clefs.clone
	forms = ex5_forms.clone
	ex5_keys.each do |this_key| 
		key_name = this_key.first 
		tonic = this_key.last 

		clef = clefs.shift
		#make sure we're in the right octave for the clef 
		if clef=="treble" 
			octave_note = "f'" 
		elsif clef=="bass"
			octave_note = "a," 
		end

		form = forms.shift
		notes = minor_forms[form].clone 
		first_note = notes.shift
%>

\score {
	\transpose a <%=tonic%> \new Staff {

		% no time sig or barlines on either exam or key
		\override Staff.BarLine #'stencil = ##f
		\override Staff.TimeSignature #'stencil = ##f

		<% if !answer_key %>
		% no key signature on exam
		\override Staff.KeySignature #'transparent = ##t
		<% end %>

		\clef <%=clef%> 
		\key a \minor 

		\relative <%=octave_note%> { 

			%first note visible as an example on both exam and key 
			<%=first_note%>?1^"<%=key_name%> <%=form%> minor"

			<% if !answer_key %>
			\hideNotes
			<% end %>
			<%=notes.join " "%>

		}
	}
}
<%	end %>

\markup {
	\wordwrap { 6. Write each pentatonic scale starting from the given note. Use accidentals (not key signatures.) 2 points each. }
}

<% 
	clefs = ex6_clefs.clone
	forms = ex6_forms.clone
	ex6_keys.each do |this_key| 
		key_name = this_key.first 
		tonic = this_key.last 

		clef = clefs.shift
		#make sure we're in the right octave for the clef 
		if clef=="treble" 
			octave_note = "c'" 
		elsif clef=="bass"
			octave_note = "e," 
		end

		form = forms.shift
		notes = pentatonic_forms[form].clone 
		first_note = notes.shift
%>

\score {
	\transpose c <%=tonic%> \new Staff {

		#(set-accidental-style 'dodecaphonic)

		% no time sig or barlines on either exam or key
		\override Staff.BarLine #'stencil = ##f
		\override Staff.TimeSignature #'stencil = ##f

		<% if !answer_key %>
		% no key signature on exam
		\override Staff.KeySignature #'transparent = ##t
		<% end %>

		\clef <%=clef%> 
		%\key c \<%=form%>

		\relative <%=octave_note%> { 

			%first note visible as an example on both exam and key 
			<%=first_note%>1^"<%=key_name%> <%=form%> pentatonic"

			<% if !answer_key %>
			\hideNotes
			<% end %>
			<%=notes.join " "%>

		}
	}
}
<%	end %>

\markup {
	\wordwrap { 7. Write a close position triad or dominant seventh chord from the given bass note corresponding to the given roman numeral in C major. 1 points each. }
}

\score {
	\relative c' {

<% ex7_triads.each do |rn|
		notes = triads[rn].clone
		bass = notes.shift
		if !answer_key
			notes = []
		end
%>
		< <%=bass%>=' <%=notes.join " "%> >1_\markup \rN { <%=rn%> }

	<%	end %>
	}
}

\markup {
	\wordwrap { 8. Label the following excerpt with roman numerals and chord symbols. The excerpt is in the major mode and contains only root position chords. 10 points. }
	\fill-line { " " } %empty line
}

% Hymn: Dundee. Duckworth p. 265

global = {
	\key ef \major
	\time 4/4
}

my_chords = \chordmode { 
	\global 
	<% if answer_key %>bf2 c:min | af bf | ef1<% end %> 
}

<% if answer_key
		rns = %w(V vi IV V I)
	else
		rns = [' ',' ',' ',' ',' ']
	end
	%>

roman_numerals = \lyricmode {
	<% if answer_key %>\set stanza = #"B:     "<% end %>
	<%	if answer_key
			rns.each do |rn| %>
				\markup \rN { <%=rn%> }
	<% 	end
		end%>
}

S = \relative c'' {
	\global
	f2 ef | ef d | ef1 \bar "|."
}

A = \relative c' {
	\global
	d2 ef | c bf | bf1 |
}

T = \relative c' {
	\global
	bf2 g | af f | g1 | 
}

B = \relative c {
	\global
	bf2 c | af bf | ef1 |
}

\score {

	\transpose ef b \new PianoStaff <<
		\new ChordNames \my_chords
		\new Staff = "high" <<
			\new Voice = "soprano" {
				\voiceOne << \S >>
		   }
			\new Voice = "alto" {
				\voiceTwo << \A >>
		}
		>>
		\new Staff = "low" <<
			\clef bass
			\new Voice = "tenor" {
				\voiceOne << \T >>
			}
			\new Voice = "bass" {
				\voiceTwo << \B >>
			}
			\new Lyrics \lyricsto "bass" { \roman_numerals }
		>>
	>>
}

\markup {
	\wordwrap { 9. Label the following excerpt with roman numerals (chord symbols not needed). The excerpt is in the major mode and may contain chords in inversion. Identify the cadence at the end of the excerpt. 10 points. }
}

% Hymn: Winchester New. Duckworth p. 266

global = {
	\key bf \major
	\time 4/4
	\partial 2
}

roman_numerals = \lyricmode {
	<% if answer_key %>
	\set stanza = #"Db:     "
	\markup \rN { I }
	\markup \rN { I 6 }
	\markup \rN { IV }
	\markup \rN { V }
	\markup \rN { vi }
	\markup \rN { ii 6 } %ii 6 5 in orig
	\markup \rN { V 7 }
	\markup \rN { I }
	<% end %>
}

S = \relative c'' {
	\global
	% repeated bf changed to a c to get rid of ii65
	d2 | bf g | f bf | c a<% if answer_key %>^"Authentic Cadence"<% end %> | bf1 \bar "|." 
}

A = \relative c' {
	\global
	f2 | f e | c b | c e | d1 
}

T = \relative c' {
	\global
	bf2 | bf bf | a g | g f | f1 
}

B = \relative c {
	\global
	bf2 | d ef | f g | ef g | bf,1
}

\score {
	\transpose bf df \new PianoStaff <<
		\new Staff = "high" <<
			\new Voice = "soprano" {
				\voiceOne << \S >>
		   }
			\new Voice = "alto" {
				\voiceTwo << \A >>
		}
		>>
		\new Staff = "low" <<
			\clef bass
			\new Voice = "tenor" {
				\voiceOne << \T >>
			}
			\new Voice = "bass" {
				\voiceTwo << \B >>
			}
			\new Lyrics \lyricsto "bass" { \roman_numerals }
		>>
	>>
}


