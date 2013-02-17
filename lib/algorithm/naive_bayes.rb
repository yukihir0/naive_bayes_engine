# coding: utf-8

module NaiveBayesEngineAlgorithm
    class NaiveBayes
        public
        def initialize
            @category_count = Hash.new(0)
            @word_count     = Hash.new { |h, k| h[k] = Hash.new(0) }
            @denominator    = Hash.new(0)
        end

        def train(doc, category)
            # count up category
            @category_count[category] += 1
           
            # count up word in category
            doc.each { |word|
               @word_count[category][word] += 1
            }

            # calculate denominator of P(word|category)
            @category_count.keys.each { |category|
                @denominator[category] = total_word(category) + total_vocabulary
            }
        end

        def score(doc, category)
            return 0.0 unless @category_count.keys.include?(category)

            doc.inject(Math::log(prob_category(category))) { |score, word|
                score += Math::log(prob_word_given_category(category, word))
                score
            }
        end

        def score_all(doc)
            # { category => score, ...}
            @category_count.keys.inject(Hash.new) { |h, category|
                h[category] = score(doc, category)
                h
            }
        end

        def classify(doc)
            nearest_category = ''
            max_prob = -Float::INFINITY
            @category_count.keys.each { |category|
                prob = score(doc, category)
                if prob > max_prob
                    nearest_category = category
                    max_prob = prob
                end
            }
            nearest_category
        end

        private
        def total_word(category)
            @word_count[category].values.inject(0) { |total, v| total += v }
        end

        def total_vocabulary
            @word_count.values.inject([]) { |all, h| all += h.keys }.uniq.length
        end

        def total_category
            @category_count.values.inject(0) { |total, v| total += v } 
        end

        def prob_category(category)
            @category_count[category].to_f / total_category.to_f
        end

        def prob_word_given_category(category, word)
            (@word_count[category][word].to_f + 1.0) / @denominator[category].to_f
        end
    end
end
