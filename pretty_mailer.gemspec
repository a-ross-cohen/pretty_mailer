# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pretty_mailer/version'

Gem::Specification.new do |spec|
  spec.name          = "pretty_mailer"
  spec.version       = PrettyMailer::VERSION
  spec.authors       = ["Adam Ross Cohen"]
  spec.email         = ["a.ross.cohen@gmail.com"]
  spec.description   = %q{PrettyMailer lets you use stylesheets to apply inline styles to emails.}
  spec.summary       = %q{Apply stylesheets to your rails mailers. PrettyMailer uses sprockets to find and parse your stylesheets, which it then applies inline to the emails HTML part. It takes css selector specificity into account, so your styles are applied as they would be with a modern web browser, taking the proper order of precedence.}
  spec.homepage      = "https://github.com/a-ross-cohen/pretty_mailer"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  
  spec.add_dependency "css_parser"
  spec.add_dependency "nokogiri"
end
