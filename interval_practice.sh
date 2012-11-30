#!/bin/bash
echo compiling notation
ruby interval_practice.rb > interval_practice.ly
lilypond interval_practice.ly
