# BowlingScore

This gem supports score calculation for a bowling game given a string of comma separated representation
of integer. The scoring rule is based on http://bowling.about.com/od/rulesofthegame/a/bowlingscoring.htm and 
https://en.wikipedia.org/wiki/Ten-pin_bowling#Scoring. The calculation consider the rules for strike and spare
rewarding. 

## Installation

  [sudo] gem install bowling_score

## Usage

```ruby
require 'bowling_score'

scores = '1,2,3,4,5,5,10,2,4'
calculator = BowlingScore::ScoreCalculator.new(scores)
calculator.calculate
# result: 52
```

## TODO

* ScoresToFramesConvertor - to convert array of integers into frames based on rules, and validate the format and validity of the array of scores.
* ScoreBoard Class - as a data structure to hold frames and responsibility to provide score status per frame and adding score to board.
* ScoreCalculator - to take ScoreBoard Class and iterate by Frames.
