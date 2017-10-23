module Toadbot

  # A console for the bot
  # Used to manage stuff
  module Console
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
      def call(arguments)
        return "Invalid number of arguments." unless arguments.count == @arguments.count
        
        # Call it, boi
        #
        # Arguments in () are
        # accessable in | |
        @block.call('no')
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
    command(:say, {string: nil, color: nil}) do | s |
      puts s
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
    
    puts @list
    
    # This loop always runs and constantly
    # gets the option from the user.
    loop do
      # This is what the console runs on.
      # This creates a constant gets form.
      #
      # i.e.:
      # say hello it me
      command = gets.chomp
      
      # Split the words into individual values
      # in an array
      #
      # i.e.:
      # {'say', 'hello', 'it', 'me'}
      command = command.split
      
      # They command keyword is the first
      # value of the command array
      keyword = command.first
      # The arguments are the next pieces
      # after the keywords
      # Only do this is arguments isn't nil.
      arguments = command.drop(1)
      puts arguments
      puts "its nil dawg" unless arguments
      
      # Iterate through the command list
      # If it matches, call the command
      @list.each do | key, c |
        # "key" is the command symbol, i.e. :say
        # "c" is the Command object instance
        if keyword.to_s == c.name.to_s
          c.call(arguments)
        end
      end
    end
    # end of loop
  end
  # end of Console
end
# end of Toadbot