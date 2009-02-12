require 'rubygems'
require 'spec/rake/spectask'

desc "Run all tests"
Spec::Rake::SpecTask.new('specs') do |t|  
  t.spec_files = FileList['test/spec_*.rb']  
  t.spec_opts = ['--options', 'test/spec.opts']  
end

task :test do        
  d = Dir.new("test")
  d.each  {|file|
    if file.include? "spec_"
      sh "spec test/#{file}"
    end
  }

end
