module Toadbot

  # Everything portaining to voice activity.
  # Downloading files, playing, joining, etc.
  module Voice
    # Extend the Command container
    #
    # Discordrb commands
    extend Discordrb::Commands::CommandContainer

    # Join the voice channel.
    command(:join, arg_types: [Discordrb::User], bucket: :command, rate_limit_message: 'chill for %time% seconds dawg no spam pls') do | event, user |
      # By default, user is user than ran command.
      # If not, user passed to command will be joined by bot.
      #
      # Override if user passed is blank
      user = event.user if user == nil

      # Channel to join is the channel user is in
      channel = user.voice_channel

      # Set msg.
      msg = <<-EOF
`Error`
You're not in a channel, #{user.nickname}. Please connect to a channel.
You can also pass a user, i.e. `#{CONFIG.prefix}join @ur_mom`
      EOF
      # Give error message unless channel != nil
      # Say msg as error msg.
      next msg unless channel

      # Finally, connect to the channel.
      BOT.voice_connect(channel)

      # Set msg.
      msg = <<-EOF
I joined you in channel `#{channel.id}`, #{user.nickname}.
      EOF
    end

    # Leave the voice channel.
    command(:leave, bucket: :command, rate_limit_message: 'chill for %time% seconds dawg no spam pls') do | event |
      # Voice destroy takes the server id.
      BOT.voice_destroy(event.server.id)
    end

    # Add a song to the playlist.
    command(:play, bucket: :command, rate_limit_message: 'u needa chill for %time% my boy') do | event |
      'too lazy to add this cmd yet lmao'
    end
  end
end
