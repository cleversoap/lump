require 'ostruct'

class Lump

    # Recursive variable container
    class Vars < OpenStruct

        # Initialize with the containers for meta and proc data
        def initialize
            @_meta = []
            @_proc = []
            super()
        end

        # Override OpenStruct new member call to also check if there
        # is any additional meta or proc info waiting.
        def new_ostruct_member(name)
            super(name)
        end

        # Assign metadata to the next variable added.
        def meta(prompt, description = nil)
            @_meta << {:prompt => prompt, :description => description, :name => nil}
        end

        # Assign a proc to the next variable added.
        def proc(pr)
            @_proc << {:proc => pr, :name => nil}
        end

        # Gets meta data for a variable
        def get_meta(name)
            result = nil
            @_meta.each do |m|
                if m[:name] == name.to_s 
                    result = m
                    break
                end
            end
            return result
        end

        # Gets a proc if one is assigned for a variable
        def get_proc(name)
            result = nil
            @_proc.each do |p|
                if p[:name] == name.to_s
                    result = p[:proc]
                    break
                end
            end
            return result
        end

    end

    # Class for processed variable entries that will used to query for values 
    class Vars
        class Entry

            attr_reader :type
            attr_reader :default
            attr_reader :prompt
            attr_reader :description
            attr_reader :action

            def initialize(type, default = nil, meta = nil, action = nil)
                @type        = type
                @default     = default.class == Symbol ? nil : default
                @prompt      = meta == nil ? nil : meta[:prompt]
                @description = meta == nil ? nil : meta[:description]
                @action      = action
            end

            def to_s
                {:type => @type,
                    :default => @default,
                    :prompt => @prompt,
                    :description => @description,
                    :action => @action}.to_s
            end

        end
    end


end
