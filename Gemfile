# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

source 'https://rubygems.org' do # Regular gems
  gem 'thing', git: 'git@github.com:ace-teknologi/buildkite-private-git-access.git', branch: 'main'

  group :test do
    gem 'rspec', require: false
    gem 'rspec-collection_matchers'
    gem 'rubocop-rspec', require: false
    gem 'simplecov', require: false
  end

  group :development, :test do
    gem 'pry'
    gem 'rubocop'
  end
end
