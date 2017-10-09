require "toadbot/version"

module Toadbot
  # Dependencies and important components:
  #
  # gems:
  # - discordrb
  # - sqlite3
  # - sequel
  # apt packages:
  # - libsodium
  # - ffmpeg
  # - frei0r-plugins
  # - sqlite3

  # External requires:
  #
  # Discordrb bot api
  require 'discordrb'
  # Yaml reading/writing api
  require 'yaml'
  # SQLite database api (for sequel)
  require 'sqlite3'
  # Ruby style SQLite code api
  require 'sequel'

  # Internal requires
  #
  # Config
  require 'toadbot/config'
  # Initial setup
  require 'toadbot/init'
  # User object
  require 'toadbot/user'



  module Xp
    # everything portaining to levels and xp

    extend Discordrb::EventContainer
    extend Discordrb::Commands::CommandContainer

    message do | event |
      # stores xp and updates stats for each msg
      # 1 xp = 1 char in msg

      # load User object, get its info
      user = User.new(event.user.id, event.server.id)

      user.xp = 0 if user.xp == nil
      user.xp_needed = CONFIG.level_increment if user.xp_needed == nil
      user.level = 0 if user.level == nil
      # if any are nil, set them accordingly

      user.xp = user.xp + event.content.length

      if user.xp / user.xp_needed >= 1
        # if xp / xp needed is greater than or equal to one, increase level
        user.level += 1
        # increase user.level by 1

        level_factor = CONFIG.level_scale * user.level
        # the increment scaling * user lvl
        # 1000 * 2
        # 2000 to get to lvl 3 at lvl 2
        user.xp_needed = user.xp_needed + CONFIG.level_increment + level_factor
        # xp needed + the base increment + ( scale * user level )
        # 3000 + 1000 + 2000
        # 6000 to get to lvl 3 at lvl 2
      end

      User.update_xp(user.id, user.server_id, user.xp, user.xp_needed, user.level)
    end

    command(:set_rank, arg_tpes: [Discordrb::User], bucket: :command, rate_limit_message: 'chill for %time% seconds dawg no spam pls') do | event, user_init |
      #

      user_init = event.user if user_init == nil

      user = User.new(user_init.id, event.server_id)

    end

    command(:rank, arg_types: [Discordrb::User], bucket: :command, rate_limit_message: 'chill for %time% seconds dawg no spam pls') do | event, user_init |
      # get user rank, level, coins
      # display nicely

      user_init = event.user if user_init == nil

      user = User.new(user_init.id, event.server.id)
      msg = <<-EOF
  `User: #{user_init.username}`
  `Server: #{event.server.name}`
  :star: **|** #{user.xp} / #{user.xp_needed} XP
  :mushroom: **|** Level #{user.level}
      EOF

      event.respond msg
    end
  end

  BOT.include! Xp



  module Utils
    # utilities commands

    extend Discordrb::Commands::CommandContainer

    command(:user, arg_types: [Discordrb::User], bucket: :command, rate_limit_message: 'chill for %time% seconds dawg no spam pls') do | event, user |
      # event.respond user.distinct
      user = event.user if user == nil

      msg = <<-EOF
  `User: #{user.username}`
  ```Id       | #{user.id}
  Distinct | #{user.distinct}
  Game     | #{user.game}
  Status   | #{user.status}
  Webhook? | #{user.webhook?}```
      EOF

      event.respond msg
    end
  end

  BOT.include! Utils



  module Misc
    # miscillaneous commands or events
    # commands that do random things
    # annoying events ecks d

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
      event.respond 'You can invite me with link: https://discordapp.com/oauth2/authorize?&client_id=' + CONFIG.client_id.to_s + '&scope=bot&permissions=0'
    end
  end

  BOT.include! Misc



  BOT.run #:async ???
  # fin


end
# end of Toadbot module
