require_relative 'lib/zt_admin/version'

Gem::Specification.new do |spec|
  spec.name          = "zt_admin"
  spec.version       = ZtAdmin::VERSION
  spec.authors       = ["Zhenya Telyukov"]
  spec.email         = ["telyukov@gmail.com"]

  spec.homepage    = "http://dummy.com"
  spec.summary     = %q{Admin BackEnd Generator for RoR 6.1 App}
  spec.description = %q{Tool to generate Admin controllers, helpers and views for a Model}
  spec.license     = "MIT"
  
  spec.required_ruby_version = Gem::Requirement.new(">= 3.0.0")

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = "bin" #"exe"
  spec.executables   = ["zt_admin"] #spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
