module BowlingScore
  # Score Calculator - taking an array or string of scores (integers)
  #                    and calculate with strike and spare rewarding
  class ScoreCalculator
    def initialize(scores)
      scores = scores.split(',') if scores.is_a? String
      @scores = scores.map(&:to_i)
    end
  end
end
