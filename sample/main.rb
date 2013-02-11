# coding: utf-8
require 'naive_bayes_engine'

def print_score(title, category, score_all)
    header = "----- #{title} -----"
    footer = '-' * header.length, ''

    puts header
    puts "classified category is '#{category}'"
    puts "spam score = #{score_all['spam']}"
    puts "ham  score = #{score_all['ham']}"
    puts footer
end


# initialize engine
naive_engine        = NaiveBayesEngine.new.to_naive
complemental_engine = NaiveBayesEngine.new.to_complemental

# train data
spam_doc = %w(bad document contains normal sentence)
ham_doc  = %w(good document contains normal sentence)

# input data
input_doc = %w(this is a bad document)

# train
naive_engine.train(spam_doc, 'spam')
naive_engine.train(ham_doc, 'ham')
complemental_engine.train(spam_doc, 'spam')
complemental_engine.train(ham_doc, 'ham')

# print naive bayes score
category  = naive_engine.classify(input_doc)
score_all = naive_engine.score_all(input_doc)
print_score('naive_bayes', category, score_all)

# print complemental naive bayes score
category  = complemental_engine.classify(input_doc)
score_all = complemental_engine.score_all(input_doc)
print_score('complemental_naive_bayes', category, score_all)

