require 'rspec/core/rake_task'
require 'find'
require 'mkmf'
require_relative 'lib/evesync'

# Global variables
VERSION = Evesync::VERSION
GEMSPEC = 'evesync.gemspec'.freeze
GEMFILE = "evesync-#{VERSION}.gem".freeze

task default: %i[lint build]

task :lint do
  sh 'rubocop -l lib bin' if find_executable 'rubocop'
end

task :rdoc do
  sh 'rdoc --ri'
  sh 'rdoc'
end

task install: [GEMFILE] do
  sh "gem install --local #{GEMFILE}"
end

task build: GEMFILE
file GEMFILE do
  sh "gem build #{GEMSPEC}"
end

RSpec::Core::RakeTask.new(:spec)

task test: :spec

task :clean, [:remove_rpm] do |_t, args|
  args.with_defaults(:remove_rpm => 1)
  rm_rf('tmp')
  rm_rf('doc')
  rm_rf('mkmf.log')
  rm_rf(Dir['*.zip'])
  rm_rf('RPM') if args[:remove_rpm] == 1
  rm_rf(Dir['evesync-*.gem'])
end

task todos: :todo
task :todo do
  puts "==== \033[0;31mTODOs\033[0m in code"
  puts `find bin lib dockerfiles -type f -exec grep --color=always TODO   \{} \+ ||:`
  puts "==== \033[0;31mFIXMEs\033[0m in code"
  puts `find bin lib dockerfiles -type f -exec grep --color=always FIXME  \{} \+ ||:`
end

task :lines do
  sh 'find . -name "*.rb" -exec grep -v -E "^\s*#|^\s*$" \{} \+ | wc -l'
end

## Docker related targets

namespace :docker do

  task :build do
    sh 'docker-compose build'
  end

  task :up do
    sh 'docker-compose up -d node-1 node-2'
  end

  task :down do
    sh 'docker-compose stop || docker-compose kill ||:'
    sh 'docker-compose rm --force ||:'
  end
end

namespace :rhel do

  begin
    @release = `git rev-list HEAD master --count`
  rescue
    @release = 0
  end

  task :rpm do
    sh("rpmbuild -bb "\
       "--define 'VERSION #{VERSION}' "\
       "--define 'RELEASE #{@release}' "\
       "--define '_builddir #{Dir.pwd}' "\
       "--define '_rpmdir #{Dir.pwd}/RPM/' "\
       "evesync.spec")
    sh('chown -R 1000:1000 RPM')
  end
end

task :'build-rpm' do
  sh('echo rake rhel:rpm | docker-compose run build-centos')
end
