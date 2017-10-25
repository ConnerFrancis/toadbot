module Toadbot

  # A console for the bot
  # Used to manage stuff
  module Console
    # Just do it.
    extend self
    
    # Give a little bit o' space.
    puts
    
    # Start the config
    DEFAULTS = {
      
      prefix:     '>',
      watch_mode: 'sync'
      
    }.freeze
    
    @config = DEFAULTS
    
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
      attr_reader :name, :arguments, :attrs
      
      # &block gets the block of code passed to the
      # method, see "test" example below
      def initialize(name, arguments = {}, attrs = {}, block)
        # Name of command
        @name = name
        
        # Arguments passed to command
        # A hash of arguments2
        @arguments = arguments
        
        # Attributes to command
        # A hash of attributes
        @attrs = {
          # Description tag
          desc: attrs[:desc] || 'No description provided.'
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
    def command(name, arguments = [], attributes = {}, &block)
      # Enter the command into the command
      # list hash with the name of the command.
      @list[name] = Command.new(name, arguments, attributes, block)
    end
    
    private def console
      # This is what the console runs on.
      # This creates a constant gets form.
      #
      # i.e.:
      # say hello it me
      print "#{@config[:prefix]} "
      string = gets.chomp
      
      # Split the words into individual values
      # in an array
      #
      # i.e.:
      # {'say', 'hello', 'it', 'me'}
      string = string.split
      # They command keyword is the first
      # value of the command array
      keyword = string.first.to_sym
      # Shift command so it removes the first portion
      # This only returns args and not the command word
      string.shift
      
      # Call the command. If it isn't found
      # give console error.
      begin
        # Simply call the command.
        # Pass the arguments, or shifted command, as
        # the given_args to the call.
        @list[keyword].call(string)
      rescue
        # Case when it doesn't exist
        unless @list[keyword]
          puts "Unknown command '#{keyword}'."
          return
        end
        # Otherwise b rly vague
        puts 'Error:'
        puts $!
      end
    end
    public
    
    # | | operators get block.call() arguments
    command(:say, {string: nil, color: nil}) do | args |
      puts args[:string]
    end
    
    command(:reload, {mod: 'config'}, {desc: 'Reloads a module. reload `module`'}) do | mod |
      # This looks ugly because it is
      # We only want the value given, and
      # not the key. This is how we do it
      # though it may be ugry.
      mod = mod[:mod]
      
      begin
        Toadbot.inload(mod)
      rescue
        puts mod.underline + ' is not a module available for reload!'.red
      end
    end
    
    command(:irb, {option: nil}) do | s |
      
    end
    
    command(:help) do
      puts 'Commands:'
      @list.each do | key, c |
        puts " | #{key} - #{c.attrs[:desc]}"
      end
    end
    
    command(:exit) do
      exit
    end
    
    # This loop always runs and constantly
    # gets the option from the user.
    def start 
      case @config[:watch_mode]
        when 'sync'
          loop {console}
        when 'async'
          console
        else
          raise "@config[:watch_mode] cannot be '#{@config[:watch_mode]}'!"
      end
    end
    
    # end of loop
  end
  # end of Console
  
  Console.start
end
# end of Toadbot