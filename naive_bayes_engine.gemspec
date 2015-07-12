# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'naive_bayes_engine/version'

Gem::Specification.new do |gem|
  gem.name          = "naive_bayes_engine"
  gem.version       = NaiveBayesEngine::VERSION
  gem.authors       = ["yukihir0"]
  gem.email         = ["yukihiro.cotori@gmail.com"]
  gem.description   = %q{'naive_bayes_engine' provides feature for classifying document by naive bayes algorithm.}
  gem.summary       = %q{'naive_bayes_engine' provides feature for classifying document by naive bayes algorithm.}
  gem.homepage      = "https://github.com/yukihir0/naive_bayes_engine"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rake", "~>10.4.2"
  gem.add_development_dependency "rspec", "~>3.3.0"
  gem.add_development_dependency "coveralls", "~>0.8.2"
end
