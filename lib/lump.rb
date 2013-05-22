require 'thor'

class Lump < Thor

	autoload :Actions, 'lump/actions'

	include Thor::Actions
	include Lump::Actions

	desc "new NAME", "Create a new lump template"
	def new(name)
		puts "Creating new template: " + name
	end

	desc "make NAME", "Build a new project from the given template"
	def make(name, path='.')
		puts "Building template from: " + name
		puts "Building it in path: " + path
	end

end
