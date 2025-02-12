# frozen_string_literal: true

require_relative "lib/sefaz/version"

Gem::Specification.new do |spec|
  spec.name    = "sefaz"
  spec.version = SEFAZ::VERSION
  spec.authors = ["Henrique Shiraishi"]
  spec.email   = ["henriqueashiraishi@gmail.com"]

  spec.summary     = "Integração com a Secretaria da Fazenda (SEFAZ)."
  spec.homepage    = "https://github.com/henriqueshiraishi/ruby-sefaz"
  spec.license     = "MIT"
  spec.required_ruby_version = ">= 2.5.1"

  spec.metadata["homepage_uri"]    = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/henriqueshiraishi/ruby-sefaz"
  spec.metadata["changelog_uri"]   = "https://github.com/henriqueshiraishi/ruby-sefaz/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "savon", "~> 2.13.0"
  spec.add_dependency "prawn", "~> 2.4.0"
  spec.add_dependency "barby", "~> 0.6.9"
  spec.add_dependency "rqrcode", "~> 0.10.1"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
