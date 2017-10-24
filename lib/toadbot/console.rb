module Toadbot

  # A console for the bot
  # Used to manage stuff
  module Console
    # Give a little bit o' space.
    puts
    
    # List of commands
    attr_reader :list
    @list = {}
    # say "henlo" red
    # 
    # :say, [string, color] do
    #   puts string.color
    # end
    
    # Used to define new commands.
    class Command
      # You can get the name and attribute of the command.
      attr_reader :name, :arguments, :attributes
      
      # &block gets the block of code passed to the
      # method, see "test" example below
      def initialize(name, arguments={}, attributes = {}, block)
        # Name of command
        @name = name
        
        # Arguments passed to command
        # A hash of arguments
        @arguments = arguments
        
        # Attributes to command
        # A hash of attributes
        @attributes = {
          # atr_name: attributes[:atr_name] || default_value
          test: attributes[:test] || nil
        }
        
        # To call the block simply do:
        # @block.call
        @block = block
      end
      
      # Define the calling method
      # This actually runs the newly defined command
      def call(given_args)
        # If the arguments given aren't equal to how many
        # arguments you need, give console error and quit.
        unless given_args.count == @arguments.count
          puts 'Invalid number of arguments.'
          puts "Provided: #{given_args.count} | Needed: #{@arguments.count}"
          return
        end
        
        # Argument parsing
        #
        # Iterate and assign each argument given
        # to the corresponding arg value.
        @arguments.each do | arg, value |
          # Push the first argument to the c.arguments hash.
          @arguments[arg] = given_args.first
          # Drop the first value in arguments to make the
          # next one the first value so it continues properly.
          given_args.shift
        end
        
        # Call it, boi
        #
        # Arguments in () are
        # accessable in | |
        @block.call(@arguments)
      end
    end
    
    # Define the console command method
    # This is essentially shorthand syntax
    # You can extend Console module for access or use Console::command
    def self.command(name, arguments = [], attributes = {}, &block)
      # Enter the command into the command
      # list hash with the name of the command.
      @list[name] = Command.new(name, arguments, attributes, block)
    end
    
    # | | operators get block.call() arguments
    command(:say, {string: nil, color: nil}) do | args |
      puts args[:string]
    end
    
    command(:exit) do
      exit
    end
    
    # command(:reload, [:module]) do
    #   begin
    #     Toadbot.inload(option)
    #   rescue
    #     puts option.red.underline + ' is not a module available for reload!'.red
    #   end
    # end
    
    # command(:irb) do
    #   puts
    #   puts 'Eval:'.bold
    #   # Get option and eval
    #   begin
    #     option = gets.chomp
    #     eval option
    #     puts 'Eval successful'.bold
    #     puts
    #   # If fail, tell an error happened
    #   rescue
    #     puts 'Error.'.bold
    #     puts
    #   end
    # end
    
    # This loop always runs and constantly
    # gets the option from the user.
    loop do
      # This is what the console runs on.
      # This creates a constant gets form.
      #
      # i.e.:
      # say hello it me
      print '> '
      command = gets.chomp
      
      # Split the words into individual values
      # in an array
      #
      # i.e.:
      # {'say', 'hello', 'it', 'me'}
      command = command.split
      # They command keyword is the first
      # value of the command array
      keyword = command.first.to_sym
      # Shift command so it removes the first portion
      # This only returns args and not the command word
      command.shift
      
      # Call the command. If it isn't found
      # give console error.
      begin
        # Simply call the command.
        # Pass the arguments, or shifted command, as
        # the given_args to the call.
        @list[keyword].call(command)
      rescue
        # Tell user the command doesn't exist
        puts "Unknown command '#{keyword}'."
      end
    end
    # end of loop
    
    # End of the console code.
    
  end
  # end of Console
end
# end of Toadbot