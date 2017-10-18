module Toadbot

  # Miscillanious commands/events
  # General annoying events/memes or commands
  module Misc
    extend Discordrb::EventContainer
    extend Discordrb::Commands::CommandContainer

    message(containing: 'my bones') do | event |
      event.respond 'owie'
    end

    message(containing: 'yoshi') do | event |
      event.user.pm('did someone say yoshi? http://bit.ly/2y0AOCe')
    end

    message(containing: ['thanks toadbot', 'thx toadbot', 'thank toadbot', 'thanx toadbot', 'thnx toadbot']) do | event |
      event.respond 'np bb :ok_hand:'
    end

    command(:ping, bucket: :command, rate_limit_message: 'chill for %time% seconds dawg no spam pls') do | event |
      event.respond 'plong'
    end

    command(:invite, bucket: :command, rate_limit_message: 'chill for %time% seconds dawg no spam pls') do | event |
      event.respond 'You can invite me with link: https://discordapp.com/oauth2/authorize?&client_id=' + CONFIG['client_id'].to_s + '&scope=bot&permissions=0'
    end
  end
end