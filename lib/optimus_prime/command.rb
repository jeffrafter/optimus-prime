module OptimusPrime
  class Command
    def initialize(handler, caller=nil)
      @handler, @caller = handler, (caller && caller[1])
    end

    def help
      @help ||= begin
        lines = file.split(/\n/)
        result = []
        i = 0
        while (string = lines[line+i]) =~ /\s*##?/
          result << string.gsub(/^\s*#*\s?/, '')
          i += 1
        end
        result.shift if result.first.empty?
        result.pop   if result.last.empty?
        result.join("\n")
      end
    end

    def file
      @file ||= File.read(@caller.split(':').first)
    end

    def line
      @caller.split(':').last.to_i
    end

    def arity
      @handler.arity
    end

    def to_proc
      case handler = @handler
      when Proc then handler
      else @handler.to_proc
      end
    end
  end
end
