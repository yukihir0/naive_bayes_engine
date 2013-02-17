# coding: utf-8
require "naive_bayes_engine/version"
require 'algorithm/naive_bayes'
require 'algorithm/complemental_naive_bayes'

class NaiveBayesEngine
    include NaiveBayesEngineAlgorithm

    # error message
    NOT_ARRAY_DOC_ERROR     = 'not instance of Array doc is inputted.'
    NIL_CATEGORY_ERROR      = 'nil or empty category is inputted.'
  
    public
    def initialize
        to_naive
    end

    def to_naive
        @algorithm = NaiveBayes.new
        self
    end

    def to_complemental
        @algorithm = ComplementalNaiveBayes.new
        self
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
