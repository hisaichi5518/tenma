module Tenma
  module Runnable
    def run(command)
      output = `#{command}`
      if !$?.success?
        raise CommandException, "Failed!"
      end

      return output
    end

    class CommandException < Exception
    end
  end
end
