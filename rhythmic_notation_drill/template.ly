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

\include "rhythms.ly"

\new Staff \relative c' {
	\override Score.BarNumber #'stencil = ##f
	\clef percussion
	
	\override Staff.TimeSignature #'stencil = ##f

	\override Staff.BarLine #'stencil = ##f
	\autoBeamOff
	\rhythms_no_ties
}

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
	\rhythms_with_ties
}

\new Staff \relative c' {
	\clef percussion
	\rhythms_with_ties
}



