module Toadbot

  # A console for the bot
  # Used to manage stuff
  module Console
    # This loop always runs and constantly
    # gets the option from the user.
    loop do
      # This is what the console runs on.
      # This creates a constant gets form.
      option = gets.chomp
      
      # Wrapper for all commands
      case option
        # When the command is exit
        # Exit the bot
        when 'exit'
          puts
          puts 'Thank you so much for-to-playing my game!'
          exit
        # When the command begins with reload
        # Reload the module given
        when /^reload\s/
          begin
            option.slice!('reload ')
            Toadbot.inload(option)
          rescue
            puts option.red.underline + ' is not a module available for reload!'.red
          end
        # Evaluate a ruby expression
        # when 'eval'
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
      end
    end
  end
end