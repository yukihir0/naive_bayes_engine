# NaiveBayesEngine

'naive_bayes_engine' provides feature for classifying document by naive bayes algorithm.

## Requirements

- ruby 1.9

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
