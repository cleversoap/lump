require 'thor'

class Lump < Thor

    require 'lump/vars'
    require 'lump/project'
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
        begin
            p, d = load(name)
        rescue Exception => e
            puts e.message
        end
    end

    desc "list", "Lists all available lumps"
    def list
    end

    desc "clone REPO [DESTINATION]", "Will clone a git repo automatically for lump, optionally into a specific directory. Can also reference a github directory by username/repo."
    def clone(repo, dest = nil)
    end

    desc "pull --all|NAME", "Updates the specified lump (if it is git based), optionally can update all lumps"
    def pull(name)
    end

end
