# coding: utf-8
require 'algorithm/naive_bayes'

class ComplementalNaiveBayes < NaiveBayes
    public
    def score(doc, category)
        return 0.0 unless @category_count.keys.include?(category)
        
        complemental_category = @category_count.keys - [category]
        doc.inject(Math::log(prob_category(category))) { |score, word|
            complemental_category.each { |c|
                score -= Math::log(prob_word_given_category(c, word))
            }
            score
        }
    end
end
