# -*- encoding: utf-8 -*-
# stub: mocha 0.9.10 ruby lib

Gem::Specification.new do |s|
  s.name = "mocha"
  s.version = "0.9.10"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["James Mead"]
  s.date = "2010-11-25"
  s.description = "      Mocking and stubbing library with JMock/SchMock syntax, which allows mocking and stubbing of methods on real (non-mock) classes.\n"
  s.email = "mocha-developer@googlegroups.com"
  s.extra_rdoc_files = ["README.rdoc", "COPYING.rdoc"]
  s.files = ["COPYING.rdoc", "README.rdoc"]
  s.homepage = "http://mocha.rubyforge.org"
  s.rdoc_options = ["--title", "Mocha", "--main", "README.rdoc", "--line-numbers"]
  s.rubyforge_project = "mocha"
  s.rubygems_version = "2.5.1"
  s.summary = "Mocking and stubbing library"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
