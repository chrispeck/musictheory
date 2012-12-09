\version "2.16.1"
\language "english"

\header {
	title = "Rhythmic Notation Drill"
	subtitle = "recopy with barlines, ties, and beams"
}

\paper {
	indent = #0
	%ragged-right = ##t
	ragged-bottom = ##t
}

my_rhythm = { 
	\clef percussion
	\time 2/4  
	c8^"1." c16 c c c c8 | c8. c16 c16 c16 c8 | c4 c4 | c2  \bar "|." 
	\break
	\time 6/8
	c4.^"2." c | c  c4 c8 | c c c  c c4 | c4 c8  c8 c4  \bar "|."
}

\include "rhythms.ly"


\new Staff \relative c' {
	\override Score.BarNumber #'stencil = ##f
	\clef percussion
	\time 6/8

	\override Staff.BarLine #'stencil = ##f
	\autoBeamOff
	\rhythms_no_ties
}

\new Staff \relative c' { 
	\clef percussion
	\time 6/8

	\autoBeamOff

	\override Score.BarNumber #'stencil = ##f
	\override Staff.BarLine #'stencil = ##f
	\override NoteHead #'transparent = ##t
	\override Stem #'transparent = ##t
	\override Flag #'transparent = ##t
	\override Dots #'transparent = ##t
	\override Tie #'transparent = ##t
	\rhythms_with_ties
}

\new Staff \relative c' {
	\clef percussion
	\time 6/8
	\rhythms_with_ties
}



