module Toadbot

  # Superadmin commands
  # These are commands only the bot owner may use
  # Be careful!
  module SuperAdmin
    # Extend the Command container
    #
    # Discordrb commands
    extend Discordrb::Commands::CommandContainer
    
    # Eval any code given to the bot
    # Useful for in-chat problem solving
    # Only bot owner may run
    command(:eval, help_available: false) do | event, *code |
      # Set cancel msg possibilities.
      msg = ['eat my shorts', 'u cant tell me what to do', 'u dont know me', 'ur not my boss meaniebutt']
      # Cancel the command if the user id is not the owner id.
      # Also, send a pm to the user.
      next event.user.pm msg.sample unless event.user.id == CONFIG['owner_id']
      
      # Begin the sequence.
      begin
        # Evaluate code if valid.
        eval code.join(' ')
      rescue
        # Throw error in chat if not valid.
       '`Error occured.`'
      end
    end
  end
  
  BOT.include! SuperAdmin
end