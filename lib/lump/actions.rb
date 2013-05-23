class Lump

    module Actions

        # Begins loading a lump project directory
        def load(name)

            # Check if the lump directory exists
            target = File.expand_path('~/.lump')
            raise "Unable to find lump (~/.lump) directory" unless File.directory? target

            # Check if the desired lump project directory exists
            target = "#{target}/#{name}"
            raise "Unable to find the project directory (#{target})" unless File.directory? target 

            # Check if a project file can be found
            project_file = "#{target}/lump.rb"
            raise "Unable to find lump configuration (#{target}/lump.rb)" unless File.exists? project_file 

            # Load the project file
            project = eval(File.open(project_file).read) 

            # Return the project object and project files directory
            return project

        end

        # Processes the project object
        def process_project(proj)
            # Thor actually has some built in functionality with .tt
            # files to detect templates, this may or may not be a good
            # idea to make use of
        end

    end

end
