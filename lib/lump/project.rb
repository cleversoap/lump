
class Lump 

    class Project

        attr_accessor :title
        attr_accessor :description

        def initialize
            @vars = Lump::Vars.new
            yield @vars if block_given?
        end

    end

end
