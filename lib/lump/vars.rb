require 'ostruct'

class Lump

    class Vars < OpenStruct

        def initialize
            @_meta = []
            @_proc = []
            super()
        end

        def new_ostruct_member(name)
            super(name)
        end

    end

end
