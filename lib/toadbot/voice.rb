module Toadbot

  # Everything portaining to voice activity.
  # Downloading files, playing, joining, etc.
  module Voice
    # Extend the Command container
    #
    # Discordrb commands
    extend Discordrb::Commands::CommandContainer
    
    # Join the voice channel.
    command(:join, arg_types: [Discordrb::User], bucket: :command, rate_limit_message: 'chill for %time% seconds dawg no spam pls') do | event, user_init |
      # By default, user is user than ran command.
      # If not, user passed to command will be joined by bot.
      #
      # Override if user_init blank
      user_init = event.user if user_init == nil
      
      # Channel to join is the channel user is in
      channel = user_init.voice.channel
      
      # Finally, connect to the channel.
      BOT.voice_connect(channel)
    end
  end
end