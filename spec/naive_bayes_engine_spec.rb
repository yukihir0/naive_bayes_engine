# coding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NaiveBayesEngine do
    context 'uninitialized' do
        describe '#initialize' do
            context 'when no type input' do
                it 'NAIVE_BAYES algorithm' do
                    engine = NaiveBayesEngine.new
                    engine.instance_eval('@algorithm').instance_of?(NaiveBayes).should be_true
                end
            end

            context 'when NAIVE_BAYES input' do
                it 'NAIVE_BAYES algorithm' do
                    engine = NaiveBayesEngine.new(type: NaiveBayesEngine::NAIVE_BAYES)
                    engine.instance_eval('@algorithm').instance_of?(NaiveBayes).should be_true
                end
            end
            
            context 'when COMPLEMENTAL_NAIVE_BAYES input' do
                it 'COMPLEMENTAL_NAIVE_BAYES algorithm' do
                    engine = NaiveBayesEngine.new(type: NaiveBayesEngine::COMPLEMENTAL_NAIVE_BAYES)
                    engine.instance_eval('@algorithm').instance_of?(ComplementalNaiveBayes).should be_true
                end
            end

            context 'invalid type input' do
                it 'raise error' do
                    expect { engine = NaiveBayesEngine.new(type: 'invalid algorithm type')
                    }.to raise_error(RuntimeError, NaiveBayesEngine::INVALID_ALGORITHM_ERROR)
                end
            end
        end
    end

    context 'initialized' do
        before(:each) do
            @category = 'test_category'
            @doc      = %w(test doc)
            @engine   = NaiveBayesEngine.new
        end

        describe '#train' do
            context 'when nil category input' do
                it 'raise error' do
                    expect { @engine.train(@doc, nil)
                    }.to raise_error(RuntimeError, NaiveBayesEngine::NIL_CATEGORY_ERROR)
                end
            end

            context 'when empty category input' do
                it 'raise error' do
                    expect { @engine.train(@doc, '')
                    }.to raise_error(RuntimeError, NaiveBayesEngine::NIL_CATEGORY_ERROR)
                end
            end

            context 'when nil doc input' do
                it 'raise error' do
                    expect { @engine.train(nil, @category)
                    }.to raise_error(RuntimeError, NaiveBayesEngine::NOT_ARRAY_DOC_ERROR)
                end
            end

            context 'when empty doc input' do
                it 'raise error' do
                    expect { @engine.train('', @category)
                    }.to raise_error(RuntimeError, NaiveBayesEngine::NOT_ARRAY_DOC_ERROR)
                end
            end

            context 'when string doc input' do
                it 'raise error' do
                    expect { @engine.train('test doc', @category)
                    }.to raise_error(RuntimeError, NaiveBayesEngine::NOT_ARRAY_DOC_ERROR)
                end
            end

            context 'when doc, category input' do
                it 'not raise error' do
                    expect { @engine.train(@doc, @category)
                    }.to_not raise_error
                end
            end
        end

        describe '#score' do
            context 'when nil doc input' do
                it 'raise error' do
                    expect { @engine.score(nil, @category)
                    }.to raise_error(RuntimeError, NaiveBayesEngine::NOT_ARRAY_DOC_ERROR)
                end
            end

            context 'when empty doc input' do
                it 'raise error' do
                    expect { @engine.score('', @category)
                    }.to raise_error(RuntimeError, NaiveBayesEngine::NOT_ARRAY_DOC_ERROR)
                end
            end

            context 'when string doc input' do
                it 'raise error' do
                    expect { @engine.score('test', @category)
                    }.to raise_error(RuntimeError, NaiveBayesEngine::NOT_ARRAY_DOC_ERROR)
                end
            end

            context 'when nil category input' do
                it 'raise error' do
                    expect { @engine.score(@doc, nil)
                    }.to raise_error(RuntimeError, NaiveBayesEngine::NIL_CATEGORY_ERROR)
                end
            end

            context 'when empty category input' do
                it 'raise error' do
                    expect { @engine.score(@doc, '')
                    }.to raise_error(RuntimeError, NaiveBayesEngine::NIL_CATEGORY_ERROR)
                end
            end

            context 'when doc, category input' do
                it '0.0' do
                    score = @engine.score(@doc, @category)
                    score.should == 0.0
                end
            end
        end

        describe '#classify' do
            context 'when nil doc input' do
                it 'raise error' do
                    expect { @engine.classify(nil)
                    }.to raise_error(RuntimeError, NaiveBayesEngine::NOT_ARRAY_DOC_ERROR)
                end
            end
            
            context 'when empty doc input' do
                it 'raise error' do
                    expect { @engine.classify('')
                    }.to raise_error(RuntimeError, NaiveBayesEngine::NOT_ARRAY_DOC_ERROR)
                end
            end

            context 'when string doc input' do
                it 'raise error' do
                    expect { @engine.classify('test doc')
                    }.to raise_error(RuntimeError, NaiveBayesEngine::NOT_ARRAY_DOC_ERROR)
                end
            end

            context 'when doc input' do
                it 'not raise error' do
                    expect { @engine.classify(@doc)
                    }.to_not raise_error
                end
            end

            context 'when doc input' do
                it 'no category' do
                    category = @engine.classify(@doc)
                    category.should == ''
                end
            end
        end

        describe '#score_all' do
            context 'when nil doc input' do
                it 'raise error' do
                    expect { @engine.score_all(nil)
                    }.to raise_error(RuntimeError, NaiveBayesEngine::NOT_ARRAY_DOC_ERROR)
                end
            end

            context 'when empty doc input' do
                it 'raise error' do
                    expect { @engine.score_all('')
                    }.to raise_error(RuntimeError, NaiveBayesEngine::NOT_ARRAY_DOC_ERROR)
                end
            end

            context 'when string doc input' do
                it 'raise error' do
                    expect { @engine.score_all('test doc')
                    }.to raise_error(RuntimeError, NaiveBayesEngine::NOT_ARRAY_DOC_ERROR)
                end
            end

            context 'when doc input' do
                it '{}' do
                    score =  @engine.score_all(@doc)
                    score.should == {}
                end
            end
        end
    end
end
