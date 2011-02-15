# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pachube-data-formats/version"

Gem::Specification.new do |s|
  s.name        = "pachube-data-formats"
  s.version     = PachubeDataFormats::VERSION::STRING
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Paul Bellamy", "Levent Ali"]
  s.email       = ["paul.a.bellamy@gmail.com", "lebreeze@gmail.com"]
  s.homepage    = "http://github.com/paulbellamy/cachew.git"
  s.summary     = %q{pachube-data-formats is a gem designed to make interfacing with pachube easier. It converts to and from Pachube's data formats.}
  s.description = <<-EOF
pachube-data-formats is a gem designed to make interfacing with pachube easier. It converts to and from Pachube's data formats.
  EOF

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.required_rubygems_version = ">=1.3.6"

  #s.add_dependency("yajl", "<=2.3.10")

  s.add_development_dependency("rake", ">=0.8.7")
  s.add_development_dependency("rspec", "=2.5.0")
  #s.add_development_dependency("mocha", ">=0.9.9")

  s.extra_rdoc_files = ["README", "CHANGELOG", "MIT-LICENSE"]
  s.rdoc_options << '--main' << 'README'
end
