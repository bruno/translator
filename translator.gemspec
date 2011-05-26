# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "translator"
  s.version     = "0.0.2"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Bruno Mattarollo"]
  s.email       = ["bruno@pollenizer.com"]
  s.homepage    = "http://github.com/bruno/translator"
  s.summary     = "Rails engine to manage translations"
  s.description = "translator is engine, that you can easily integrate with your administration panel, and let your clients do the dirty work translating the site. Forked from work of hubert.lepicki@amberbit.com"

  s.required_rubygems_version = ">= 1.3.6"

  s.files        = Dir.glob("{app,lib,config}/**/*") + %w(LICENSE README.rdoc)
  s.require_path = 'lib'
end

