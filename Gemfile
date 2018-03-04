source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in rbstarbound.gemspec
gemspec

# load local gemfile
['Gemfile.local.rb', 'Gemfile.local'].map do |file_name|
  local_gemfile = File.join(File.dirname(__FILE__), file_name)
  instance_eval(Bundler.read_file(local_gemfile)) if File.exist?(local_gemfile)
end
