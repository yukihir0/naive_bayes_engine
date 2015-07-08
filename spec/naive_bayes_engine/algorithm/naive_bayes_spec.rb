# coding: utf-8
require File.expand_path('spec/spec_helper')
include NaiveBayesEngineAlgorithm

describe NaiveBayes do
  context 'uninitialized' do
    describe '#initialize' do
      context 'when no input' do
        it 'initialize' do
          expect { algorithm = NaiveBayes.new
          }.to_not raise_error
        end
      end
    end
  end

  context 'initialized' do
    before(:each) do
      @category  = 'test_category'
      @doc       = %w(test doc)
      @algorithm = NaiveBayes.new
    end

    describe '#train' do
      context 'when category input' do
        it 'count up category_count' do
          @algorithm.train(@doc, @category)
          category_count = @algorithm.instance_eval('@category_count')
          category_count.should == {'test_category' => 1}
        end
      end

      context 'when doc input' do
        it 'count up word_count' do
          @algorithm.train(@doc, @category)
          word_count = @algorithm.instance_eval('@word_count')
          word_count.should == {'test_category' => {'test' => 1, 'doc' => 1}}
        end
      end

      context 'when category, doc input' do
        it 'calculate denominator' do
          @algorithm.train(@doc, @category)
          denominator = @algorithm.instance_eval('@denominator')
          denominator.should == {'test_category' => 4}
        end
      end
    end

    describe '#score' do
      context 'when doc, category input' do
        it '0.0' do
          score = @algorithm.score(@doc, @category)
          score.should == 0.0
        end
      end
    end

    describe '#score_all' do
      context 'when doc input' do
        it '{}' do
          scores = @algorithm.score_all(@doc)
          scores.should == {}
        end
      end
    end

    describe '#classify' do
      context 'when doc input' do
        it 'no category' do
          category = @algorithm.classify(@doc)
          category.should == ''
        end
      end
    end
  end

  context 'train 1 doc' do
    before(:each) do
      @train_category = 'test01'
      @train_doc      = %w(test01 doc)
      @category  = 'test02'
      @doc       = %w(test02 doc)

      @algorithm = NaiveBayes.new
      @algorithm.train(@train_doc, @train_category)
    end

    describe '#train' do
      context 'when category input' do
        it 'count up category_count' do
          @algorithm.train(@doc, @category)
          category_count = @algorithm.instance_eval('@category_count')
          category_count.should == {'test01' => 1, 'test02' => 1}
        end
      end

      context 'when doc input' do
        it 'count up word_count' do
          @algorithm.train(@doc, @category)
          word_count = @algorithm.instance_eval('@word_count')
          word_count.should == {'test01' => {'test01' => 1, 'doc' => 1},
                                'test02' => {'test02' => 1, 'doc' => 1}}
        end
      end

      context 'when category, doc input' do
        it 'calculate denominator' do
          @algorithm.train(@doc, @category)
          denominator = @algorithm.instance_eval('@denominator')
          denominator.should == {'test01' => 5, 'test02' => 5}
        end
      end
    end

    describe '#score' do
      context 'when not trained category input' do
        it '0.0' do
          score = @algorithm.score(@doc, @category)
          score.should == 0.0
        end
      end

      context 'when doc, category input' do
        it '-2.079' do
          score = @algorithm.score(@doc, @train_category)
          score.should be_within(0.001).of(-2.079)
        end
      end
    end

    describe '#score_all' do
      context 'when doc input' do
        it '{test01 => -2.079}' do
          scores = @algorithm.score_all(@doc)
          scores[@train_category].should be_within(0.001).of(-2.079)
        end
      end
    end

    describe '#classify' do
      context 'when doc input' do
        it 'test01' do
          category = @algorithm.classify(@doc)
          category.should == 'test01'
        end
      end
    end
  end

  context 'train 2 doc' do
    before(:each) do
      @train_category_01 = 'test01'
      @train_doc_01      = %w(test01 doc)
      @train_category_02 = 'test02'
      @train_doc_02      = %w(test02 doc)
      @category  = 'test03'
      @doc       = %w(test01 text)

      @algorithm = NaiveBayes.new
      @algorithm.train(@train_doc_01, @train_category_01)
      @algorithm.train(@train_doc_02, @train_category_02)
    end

    describe '#train' do
      context 'when category input' do
        it 'count up category_count' do
          @algorithm.train(@doc, @category)
          category_count = @algorithm.instance_eval('@category_count')
          category_count.should == {'test01' => 1, 'test02' => 1, 'test03' => 1}
        end
      end

      context 'when doc input' do
        it 'count up word_count' do
          @algorithm.train(@doc, @category)
          word_count = @algorithm.instance_eval('@word_count')
          word_count.should == {'test01' => {'test01' => 1, 'doc' => 1},
                                'test02' => {'test02' => 1, 'doc' => 1},
                                'test03' => {'test01' => 1, 'text' => 1}}
        end
      end

      context 'when category, doc input' do
        it 'calculate denominator' do
          @algorithm.train(@doc, @category)
          denominator = @algorithm.instance_eval('@denominator')
          denominator.should == {'test01' => 6, 'test02' => 6, 'test03' => 6}
        end
      end
    end

    describe '#score' do
      context 'when not trained category input' do
        it '0.0' do
          score = @algorithm.score(@doc, @category)
          score.should == 0.0
        end
      end

      context 'when doc, category_01 input' do
        it '-3.218' do
          score = @algorithm.score(@doc, @train_category_01)
          score.should be_within(0.001).of(-3.218)
        end
      end

      context 'when doc, category_02 input' do
        it '-3.912' do
          score = @algorithm.score(@doc, @train_category_02)
          score.should be_within(0.001).of(-3.912)
        end
      end
    end

    describe '#score_all' do
      context 'when doc input' do
        it '{test01 => -3.218, test02 -> -3.912}' do
          scores = @algorithm.score_all(@doc)
          scores[@train_category_01].should be_within(0.001).of(-3.218)
          scores[@train_category_02].should be_within(0.001).of(-3.912)
        end
      end
    end

    describe '#classify' do
      context 'when doc input' do
        it 'test01' do
          category = @algorithm.classify(@doc)
          category.should == 'test01'
        end
      end
    end
  end
end
