require_relative "lib/set_operations/version"

Gem::Specification.new do |spec|
  spec.name          = "set_operations"
  spec.version       = SetOperations::VERSION
  spec.summary       = "A gem for set operations like union, intersection, and difference."
  spec.description   = "This gem provides basic operations for sets, such as union, intersection, and difference."
  spec.authors       = ["Yaroslav Vovk"]
  spec.email         = ["yarikvovk800@gmail.com"]
  spec.license       = "MIT"
  spec.homepage      = "https://your.repo.url"
  spec.required_ruby_version = ">= 2.5.0"

  # Specify the files to include in the gem
  spec.files         = Dir["lib/**/*.rb"]
  spec.require_paths = ["lib"]

  # Specify an executable (if needed)
  spec.bindir        = "bin"
  spec.executables   = Dir["bin/*"].map { |f| File.basename(f) }

  # Add runtime dependencies here if needed
  # spec.add_dependency "some-gem", "~> 1.0"
end