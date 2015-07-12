# NaiveBayesEngine [![Build Status](https://travis-ci.org/yukihir0/naive_bayes_engine.png?branch=master)](https://travis-ci.org/yukihir0/naive_bayes_engine) [![Coverage Status](https://coveralls.io/repos/yukihir0/naive_bayes_engine/badge.svg?branch=master&service=github)](https://coveralls.io/github/yukihir0/naive_bayes_engine?branch=master)

'naive_bayes_engine' provides feature for classifying document by naive bayes algorithm.

## Requirements

- ruby >= 2.0

## Install

Add this line to your application's Gemfile:

```
gem 'naive_bayes_engine', :github => 'yukihir0/naive_bayes_engine'
```

And then execute:

```
% bundle install
```

## How to use

```
engine = NaiveBayesEngine.new

engine.train('this is a spam document', 'spam')
engine.train('this is a ham document', 'ham')

category = engine.classify('this is a maybe spam document')
puts category
```

For more information, please see [here](https://github.com/yukihir0/naive_bayes_engine/blob/master/sample/main.rb).

## License

Copyright &copy; 2013 yukihir0
