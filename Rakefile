require 'rubygems'
require 'spec/rake/spectask'

desc "Run all tests"
Spec::Rake::SpecTask.new('specs') do |t|  
  t.spec_files = FileList['test/spec_*.rb']  
  t.spec_opts = ['--options', 'test/spec.opts']  
end
