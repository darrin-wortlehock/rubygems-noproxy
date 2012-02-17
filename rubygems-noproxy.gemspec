# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rubygems-noproxy/version"

Gem::Specification.new do |s|
  s.name        = "rubygems-noproxy"
  s.version     = Rubygems::Noproxy::VERSION
  s.authors     = ["Darrin Wortlehock"]
  s.email       = ["darrin@exempla.co.uk"]
  s.homepage    = "http://github.com/exempla/rubygems-noproxy"
  s.summary     = %q{Fix ENV['no_proxy'] behavior in rubygems}
  s.description = %q{A rubygems plugin that monkey-patches rubygems to support the no_proxy environment variable}

  s.rubyforge_project = "rubygems-noproxy"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
