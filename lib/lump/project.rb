
class Lump 

    class Project

        # Title of the project
        attr_accessor :title

        # Description of the project
        attr_accessor :description

        # Files that won't be processed but will still be copied
        attr_accessor :skipped_files

        # Files that won't be processed and will not be copied
        attr_accessor :removed_files

        # Variables
        attr_accessor :vars

        def initialize
            @skipped_files = []
            @removed_files = []
            @vars = Lump::Vars.new
            yield @vars if block_given?
        end

    end

end
