source ENV['GEM_SOURCE'] || 'https://rubygems.org'

group :test do
  gem 'rake'
  gem 'puppet', ENV['PUPPET_GEM_VERSION'] || '~> 4.0'
  gem 'rspec'
  gem 'rspec-puppet'
  gem 'puppetlabs_spec_helper'
  gem 'metadata-json-lint'
  gem 'rspec-puppet-facts'
  gem 'simplecov', '>= 0.9.0'
  gem 'simplecov-console'
  gem 'coveralls', :require => false

  gem 'puppet-lint-absolute_classname-check'
  gem 'puppet-lint-leading_zero-check'
  gem 'puppet-lint-trailing_comma-check'
  gem 'puppet-lint-version_comparison-check'
  gem 'puppet-lint-classes_and_types_beginning_with_digits-check'
  gem 'puppet-lint-unquoted_string-check'

  gem 'rest-client'
  gem 'webmock', '< 2.0'
  gem 'mocha'
  gem 'fakefs'

  gem 'json'
  gem 'tins'
  gem 'rubocop', '0.44.1'
end

group :development do
  gem 'travis'
  gem 'travis-lint'
  gem 'puppet-blacksmith'
  gem 'guard-rake'
end

group :system_tests do
  gem 'beaker'
  gem 'beaker-rspec'
  gem 'beaker-puppet_install_helper'
  gem 'beaker_spec_helper'
end
