# -*- encoding: utf-8 -*-
# stub: mdl 0.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "mdl"
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Mark Harrison"]
  s.date = "2015-04-13"
  s.description = "Style checker/lint tool for markdown files"
  s.email = ["mark@mivok.net"]
  s.executables = ["mdl"]
  s.files = ["bin/mdl"]
  s.homepage = "http://github.com/mivok/markdownlint"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2")
  s.rubygems_version = "2.2.3"
  s.summary = "Markdown lint tool"

  s.installed_by_version = "2.2.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<kramdown>, [">= 1.5.0", "~> 1.5"])
      s.add_runtime_dependency(%q<mixlib-config>, [">= 2.1.0", "~> 2.1"])
      s.add_runtime_dependency(%q<mixlib-cli>, [">= 1.5.0", "~> 1.5"])
      s.add_development_dependency(%q<bundler>, ["~> 1.5"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
      s.add_development_dependency(%q<minitest>, ["~> 5.0"])
      s.add_development_dependency(%q<pry>, ["~> 0.10"])
    else
      s.add_dependency(%q<kramdown>, [">= 1.5.0", "~> 1.5"])
      s.add_dependency(%q<mixlib-config>, [">= 2.1.0", "~> 2.1"])
      s.add_dependency(%q<mixlib-cli>, [">= 1.5.0", "~> 1.5"])
      s.add_dependency(%q<bundler>, ["~> 1.5"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
      s.add_dependency(%q<minitest>, ["~> 5.0"])
      s.add_dependency(%q<pry>, ["~> 0.10"])
    end
  else
    s.add_dependency(%q<kramdown>, [">= 1.5.0", "~> 1.5"])
    s.add_dependency(%q<mixlib-config>, [">= 2.1.0", "~> 2.1"])
    s.add_dependency(%q<mixlib-cli>, [">= 1.5.0", "~> 1.5"])
    s.add_dependency(%q<bundler>, ["~> 1.5"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
    s.add_dependency(%q<minitest>, ["~> 5.0"])
    s.add_dependency(%q<pry>, ["~> 0.10"])
  end
end
