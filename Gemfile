source 'https://rubygems.org' do
  gem 'full_dup'
  gem 'hashdiff', '~> 0.3.8'
  gem 'lmdb'
  gem 'rb-inotify', '0.9.9' # Last available on ruby 2.0.0
  gem 'toml-rb', '~> 1.1.2'
  gem 'rubyzip', '~> 1.3.0'
  gem 'net-ntp'

  group :arch do
    gem 'file-tail'
  end

  group :test do
    gem 'rspec', require: false
    gem 'codecov', require: false
  end

  group :development do
    gem 'rubocop', require: false
    gem 'rake', '>= 12.3.3'
  end
end
