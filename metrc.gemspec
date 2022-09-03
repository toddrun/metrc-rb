Gem::Specification.new do |spec|
  spec.name = "metrc"
  spec.version = "0.0.0"
  spec.authors = ["Todd Runstein"]
  spec.email = ["toddrun@gmail.com"]
  spec.summary = "Metrc library for Ruby"
  spec.description = "Ruby wrapper for the Metrc API"
  spec.homepage = "https://github.com/toddrun"
  spec.license = "MIT"
  spec.files = Dir['./**/*.rb']
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry-byebug"

  spec.add_runtime_dependency "faraday"
  spec.add_runtime_dependency "faraday_middleware"
end
