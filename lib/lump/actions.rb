class Lump

    require 'yaml'
    require 'ostruct'

    module Actions

        # Begins loading a lump project directory
        def load(name)

            # Check if the lump directory exists
            target_dir = File.expand_path('~/.lump')
            raise "Unable to find lump (#{target_dir}) directory" unless File.directory? target_dir

            # Check if the desired lump project directory exists
            target_dir = "#{target_dir}/#{name}"
            raise Thor::Error, "Unable to find the project directory (#{target_dir})" unless File.directory? target_dir 

            # Check if a project file can be found
            project_file = "#{target_dir}/lump.rb"
            raise Thor::Error, "Unable to find lump configuration (#{target_dir}/lump.rb)" unless File.exists? project_file 

            # Check if the files directory can be found
            template_dir = "#{target_dir}/template"
            raise Thor::Error, "Unable to find templates directory (#{template_dir})" unless File.directory? template_dir

            # Check if the manifest file can be found
            manifest_file = "#{target_dir}/manifest.yml"
            raise Thor::Error, "Unable to find manifest file (#{manifest_file})" unless File.exists? manifest_file

            # Load the project file
            project_file = eval(File.open(project_file).read) 

            # Read the manifest file
            manifest_file = YAML.load_file(manifest_file)

            # Load the template directory
            template_dir = Dir.new(template_dir)

            # Return the project object, manifest file, template directory
            return project_file, manifest_file, template_dir

        end

        # Processes the project object
        def process_vars(vars)
            result = OpenStruct.new
            vars.each_pair do |k,v|

                #puts "#{k} -> #{v}"

                # Get any meta data if it exists
                m = vars.get_meta(k)
                p = vars.get_proc(k)

                result[k] = case v

                            when :list, Array
                                Vars::Entry.new(:list, v, m, p)

                            when :number, Fixnum, Float
                                Vars::Entry.new(:number, v, m, p)

                            when :string
                                Vars::Entry.new(:string, v, m, p)

                            when :bool, TrueClass, FalseClass
                                Vars::Entry.new(:bool, v, m, p)

                            when Group
                                v.vars = process_vars(v.vars)
                                v
                            end

            end
            return result
        end

    end

end
