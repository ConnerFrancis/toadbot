module Toadbot

  # All commands/events having to do with user levels and xp.
  # Uses User class for storage.
  module Xp
    # Extend the Event and Command container
    # 
    # Discordrb events
    extend Discordrb::EventContainer
    # Discordrb commands
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

    command(:set_rank, arg_types: [Discordrb::User], bucket: :command, rate_limit_message: 'chill for %time% seconds dawg no spam pls') do | event, user_init |
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
end