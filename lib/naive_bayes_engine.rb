# coding: utf-8
require "naive_bayes_engine/version"
require 'algorithm/naive_bayes'
require 'algorithm/complemental_naive_bayes'

class NaiveBayesEngine
    
    # error message
    NIL_CATEGORY_ERROR      = 'nil or empty category is inputted.'
    NOT_ARRAY_DOC_ERROR     = 'not instance of Array doc is inputted.'
    INVALID_ALGORITHM_ERROR = 'invalid algorithm is inputted.'
  
    # algorithm type
    NAIVE_BAYES              = 'naive bayes'
    COMPLEMENTAL_NAIVE_BAYES = 'complemental naive bayes'

    public
    def initialize(options = {type: NAIVE_BAYES})
        case options[:type]
        when NAIVE_BAYES
            @algorithm = NaiveBayes.new
        when COMPLEMENTAL_NAIVE_BAYES
            @algorithm = ComplementalNaiveBayes.new
        else
            raise INVALID_ALGORITHM_ERROR
        end
    end

    def train(doc, category)
        raise NOT_ARRAY_DOC_ERROR if not_instance_of_array?(doc)
        raise NIL_CATEGORY_ERROR  if nil_or_empty?(category)
        
        @algorithm.train(doc, category)
    end

    def score(doc, category)
        raise NOT_ARRAY_DOC_ERROR if not_instance_of_array?(doc)
        raise NIL_CATEGORY_ERROR  if nil_or_empty?(category)

        @algorithm.score(doc, category)
    end

    def score_all(doc)
        raise NOT_ARRAY_DOC_ERROR if not_instance_of_array?(doc)

        @algorithm.score_all(doc)
    end

    def classify(doc)
        raise NOT_ARRAY_DOC_ERROR if not_instance_of_array?(doc)

        @algorithm.classify(doc)
    end

    private
    def nil_or_empty?(category)
        category.nil? || category.empty?
    end

    def not_instance_of_array?(doc)
        !doc.instance_of?(Array)
    end
end
