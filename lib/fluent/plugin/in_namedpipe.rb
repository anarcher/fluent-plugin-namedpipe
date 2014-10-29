module Fluent
    class NamedPipeInput < Input
        Plugin.register_input('namedpipe',self)

        unless method_defined?(:log)
            define_method(:log) { $log }
        end

        def initialize
            super
            @path = nil
        end

        config_param :path, :string
        config_param :tag , :string

        def configure(conf)
            super

            if !File.exists(@path)
                raise ConfigError,"File not found #{@path}"
            end

            configure_parser(conf)
            configure_tag

        end


        def configure_parser(conf)
            @parser = TextParser.new
            @parser.configure(conf)
        end

        def configure_tag
            if @tag.index('*')
                @tag_prefix, @tag_suffix = @tag.split('*')
                @tag_suffix ||= ''
            else
                @tag_prefix = nil
                @tag_suffix = nil
            end

        end

        def parse_line(line)
            return @parser.parse(line)
        end

        def start
            super
            @pipe = open(@path,"r+")
        end

        def run
            loop do
                line = @pipe.gets
                time, record = parse_line(line)
                log.debug("Line: #{time} #{record}")
                if time && record
                    Engine.emit(@msg,time,record)
                else
                    log.warn "Pattern not match: #{line.inspect}"
                end
            end
        end

        def shutdown
            super
            @pipe.close()
        end
    end
end
