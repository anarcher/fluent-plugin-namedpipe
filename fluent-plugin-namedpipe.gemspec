# -*- encoding: utf-8 -*-
Gem::Specification.new do |gem|
  gem.name          = "fluent-plugin-namedpipe"
  gem.version       = "0.0.2"
  gem.authors       = ["anarcher"]
  gem.email         = ["anarcher@gmail.com"]
  gem.description   = %q{fluentd plugin to named pipe input }
  gem.summary       = %q{fluentd plugin to named pipe input }
  gem.homepage      = "https://github.com/anarcher/fluent-plugin-namedpipe"
  gem.license       = "APLv2"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rake"
  gem.add_runtime_dependency "fluentd"
end
