# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cucumber_analytics/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Eric Kessler']
  gem.email         = ['morrow748@gmail.com']
  gem.description   = %q{Static analysis of Cucumber tests made easy.}
  gem.summary       = %q{This gem provides an API to programmatically break down Cucumber feature files so that they can be inspected and analyzed in a straightforward manner.}
  gem.homepage      = 'https://github.com/enkessler/cucumber_analytics'

  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'cucumber_analytics'
  gem.require_paths = ['lib']
  gem.version       = CucumberAnalytics::VERSION

  gem.add_runtime_dependency('gherkin', '< 3.0')
  gem.add_runtime_dependency('json', '~> 1.0')
  gem.add_runtime_dependency('multi_json', '~> 1.0')

  gem.add_development_dependency 'rake', '< 12.0.0'
  gem.add_development_dependency 'cucumber', '< 3.0.0'
  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'simplecov', '< 1.0.0'
  gem.add_development_dependency 'racatt', '~> 1.0'
  gem.add_development_dependency 'coveralls', '< 1.0.0'
end
