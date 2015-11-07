require 'spec_helper'

describe BowlingScore::ScoreCalculator do
  subject { described_class.new(score_array) }
  let(:score_array) { [rand(11), rand(11), rand(11)] }

  describe '#initialize' do
    context 'with array of scores' do
      it 'assigns with array of scores' do
        expect(subject.instance_variable_get(:@scores)).to eq score_array
      end

      context 'with with non-integer character' do
        it 'convert to zero and assigns' do
          params = [1, 2, 'abc', 4]
          new_subject = described_class.new(params)
          expected = [1, 2, 0, 4]
          expect(new_subject.instance_variable_get(:@scores)).to eq expected
        end
      end

      context 'with with string of integer' do
        it 'convert to integer and assigns with array of scores' do
          params = %w(1 2 3 4)
          new_subject = described_class.new(params)
          expected = [1, 2, 3, 4]
          expect(new_subject.instance_variable_get(:@scores)).to eq expected
        end
      end

      context 'with array of score mixed' do
        context 'with non-integer character preceeding integer' do
          it 'convert to array with zero for that score and assigns' do
            params = [1, 2, 3, 'abc4', 5]
            new_subject = described_class.new(params)
            expected = [1, 2, 3, 0, 5]
            expect(new_subject.instance_variable_get(:@scores)).to eq expected
          end
        end

        context 'with integer preceeding non-integer character' do
          it 'convert to array with the integer for that score and assigns' do
            params = [1, 2, 3, '4abc', 5]
            new_subject = described_class.new(params)
            expected = (1..5).to_a
            expect(new_subject.instance_variable_get(:@scores)).to eq expected
          end
        end
      end
    end

    context 'with string representation of scores' do
      context 'with proper comma separated integer' do
        it 'convert to array and assigns with array of scores' do
          params = '1,2,3,4,5,6'
          new_subject = described_class.new(params)
          expected = (1..6).to_a
          expect(new_subject.instance_variable_get(:@scores)).to eq expected
        end
      end

      context 'with string of non-integer character' do
        it 'convert to array of zeroes and assigns with array of scores' do
          params = 'abc,%^&'
          new_subject = described_class.new(params)
          expected = [0, 0]
          expect(new_subject.instance_variable_get(:@scores)).to eq expected
        end
      end

      context 'with string of score mixed' do
        context 'with non-integer character preceeding integer' do
          it 'convert to array with zero for that score and assigns' do
            params = '1,2,3,abc4, 5'
            new_subject = described_class.new(params)
            expected = [1, 2, 3, 0, 5]
            expect(new_subject.instance_variable_get(:@scores)).to eq expected
          end
        end

        context 'with integer preceeding non-integer character' do
          it 'convert to array with the integer for that score and assigns' do
            params = '1,2,3,4abc, 5'
            new_subject = described_class.new(params)
            expected = (1..5).to_a
            expect(new_subject.instance_variable_get(:@scores)).to eq expected
          end
        end
      end
    end
  end

  describe '#calculate' do
    context 'with a perfect game of a 12 frames scenario' do
      it 'returns 300' do
        test_array = Array.new(12) { 10 }
        subject.instance_variable_set(:@scores, test_array)
        expect(subject.calculate).to eq 300
      end
    end

    context 'with a game of zeroes' do
      it 'returns 0' do
        test_array = Array.new(10) { 0 }
        subject.instance_variable_set(:@scores, test_array)
        expect(subject.calculate).to eq 0
      end
    end

    context 'with a single strike' do
      context 'as the last score' do
        it 'returns sum of all scores' do
          test_array = [1, 1, 10]
          subject.instance_variable_set(:@scores, test_array)
          sum = test_array.reduce(:+)
          expect(subject.calculate).to eq(sum)
        end
      end

      context 'followed by scores of 2' do
        it 'returns sum of all scores plus 2' do
          test_array = [1, 1, 10, 2]
          subject.instance_variable_set(:@scores, test_array)
          sum = test_array.reduce(:+)
          expect(subject.calculate).to eq(sum + 2)
        end
      end

      context 'followed by scores of 2 and 3' do
        it 'returns sum of all scores plus 5' do
          test_array = [1, 1, 10, 2, 3]
          subject.instance_variable_set(:@scores, test_array)
          sum = test_array.reduce(:+)
          expect(subject.calculate).to eq(sum + 5)
        end
      end
    end

    context 'with a double' do
      context 'as the last score' do
        it 'returns sum of all scores plus 10' do
          test_array = [1, 1, 10, 10]
          subject.instance_variable_set(:@scores, test_array)
          sum = test_array.reduce(:+)
          expect(subject.calculate).to eq(sum + 10)
        end
      end

      context 'followed by scores of 3' do
        it 'returns sum of all scores plus 13 and 3' do
          test_array = [1, 1, 10, 10, 3]
          subject.instance_variable_set(:@scores, test_array)
          sum = test_array.reduce(:+)
          expect(subject.calculate).to eq(sum + 13 + 3)
        end
      end

      context 'followed by scores of 3 and 4' do
        it 'returns sum of all scores plus 13 and 7' do
          test_array = [1, 1, 10, 10, 3, 4]
          subject.instance_variable_set(:@scores, test_array)
          sum = test_array.reduce(:+)
          expect(subject.calculate).to eq(sum + 13 + 7)
        end
      end
    end

    context 'with a turkey followed by scores of 4 and 5' do
      it 'returns sum of all scores plus 14 and 9' do
        test_array = [1, 1, 10, 10, 10, 4, 5]
        subject.instance_variable_set(:@scores, test_array)
        sum = test_array.reduce(:+)
        expect(subject.calculate).to eq(sum + 20 + 14 + 9)
      end
    end

    context 'with a spare' do
      context 'as the last score' do
        it 'returns sum of all scores' do
          test_array = [1, 1, 5, 5]
          subject.instance_variable_set(:@scores, test_array)
          sum = test_array.reduce(:+)
          expect(subject.calculate).to eq(sum)
        end
      end

      context 'followed by score of 4' do
        it 'returns sum of all scores plus 4' do
          test_array = [1, 1, 5, 5, 4]
          subject.instance_variable_set(:@scores, test_array)
          sum = test_array.reduce(:+)
          expect(subject.calculate).to eq(sum + 4)
        end
      end
    end

    context 'with a spare followed by a strike, then 3 and 4' do
      it 'returns sum of all scores plus 10, 3 and 4' do
        test_array = [1, 1, 5, 5, 10, 3, 4]
        subject.instance_variable_set(:@scores, test_array)
        sum = test_array.reduce(:+)
        expect(subject.calculate).to eq(sum + 10 + 3 + 4)
      end
    end

    context 'with a strike followed by a spare of 4 and 6, then 3 and 4' do
      it 'returns sum of all scores plus 4, 6 and 3' do
        test_array = [1, 1, 10, 4, 6, 3, 4]
        subject.instance_variable_set(:@scores, test_array)
        sum = test_array.reduce(:+)
        expect(subject.calculate).to eq(sum + 4 + 6 + 3)
      end
    end
  end
end
