Gem::Specification.new do |s|
  s.name = %q{erlectricity}
  s.version = "0.2.1"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Scott Fleckenstein"]
  s.date = %q{2008-06-04}
  s.description = %q{A library to interface erlang and ruby through the erlang port system}
  s.email = %q{nullstyle@gmail.com}
  s.extensions = ["ext/extconf.rb"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["CONTRIBUTORS", "History.txt", "Manifest.txt", "README.txt", "Rakefile", "examples/gruff/gruff.erl", "examples/gruff/gruff_provider.rb", "examples/gruff/gruff_run.erl", "examples/gruff/stat_run.erl", "examples/gruff/stat_writer.erl", "examples/tinderl/tinderl.erl", "examples/tinderl/tinderl.rb", "ext/decoder.c", "ext/extconf.rb", "lib/erlectricity.rb", "lib/erlectricity/condition.rb", "lib/erlectricity/conditions/hash.rb", "lib/erlectricity/conditions/static.rb", "lib/erlectricity/conditions/type.rb", "lib/erlectricity/constants.rb", "lib/erlectricity/decoder.rb", "lib/erlectricity/encoder.rb", "lib/erlectricity/errors/decode_error.rb", "lib/erlectricity/errors/encode_error.rb", "lib/erlectricity/errors/erlectricity_error.rb", "lib/erlectricity/matcher.rb", "lib/erlectricity/port.rb", "lib/erlectricity/receiver.rb", "lib/erlectricity/types/function.rb", "lib/erlectricity/types/list.rb", "lib/erlectricity/types/new_function.rb", "lib/erlectricity/types/new_reference.rb", "lib/erlectricity/types/pid.rb", "lib/erlectricity/types/reference.rb", "lib/erlectricity/version.rb", "setup.rb", "test/condition_spec.rb", "test/decode_spec.rb", "test/encode_spec.rb", "test/matcher_spec.rb", "test/port_spec.rb", "test/receiver_spec.rb", "test/spec_suite.rb", "test/test_erlectricity.rb", "test/test_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://erlectricity.rubyforge.org}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib", "ext"]
  s.rubyforge_project = %q{erlectricity}
  s.rubygems_version = %q{1.1.1}
  s.summary = %q{A library to interface erlang and ruby through the erlang port system}
  s.test_files = ["test/test_erlectricity.rb", "test/test_helper.rb"]

  s.add_dependency(%q<concurrent>, ["= 0.2.2"])
end
