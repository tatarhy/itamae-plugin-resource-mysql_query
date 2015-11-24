# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "itamae-plugin-resource-mysql_query"
  spec.version       = "0.0.1"
  spec.authors       = ["tatarhy"]
  spec.email         = ["tat.j.kikyo@gmail.com"]

  spec.summary       = %q{Itamae resource plugin to run mysql query.}
  spec.description   = %q{Itamae resource plugin to run mysql query.}
  spec.homepage      = "https://github.com/tatarhy/itamae-plugin-resource-mysql_query"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_dependency "itamae"
end
