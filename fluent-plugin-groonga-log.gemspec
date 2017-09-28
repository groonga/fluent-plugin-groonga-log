lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name    = "fluent-plugin-groonga-log"
  spec.version = "0.1.1"
  spec.authors = ["Yasuhiro Horimoto"]
  spec.email   = ["horimoto@clear-code.com"]

  spec.summary       = "Fluentd plugin to parse Groonga's log."
  spec.description   = "You can detect Groonga error in real time by using this plugin."
  spec.homepage      = "https://github.com/groonga/fluent-plugin-groonga-log.git"
  spec.license       = "LGPL-3"

  test_files, files  = `git ls-files -z`.split("\x0").partition do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.files         = files
  spec.executables   = files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = test_files
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "test-unit", "~> 3.0"
  spec.add_runtime_dependency "fluentd", [">= 0.14.10", "< 2"]
  spec.add_runtime_dependency "groonga-log"
end
