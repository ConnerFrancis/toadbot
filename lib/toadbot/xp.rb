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

    # Update XP for every message a user sends.
    # 1 xp = 1 char
    message do | event |
      # RUNDOWN:
      # On every message a user sends:
      # 1. Get user
      # 2. Update values if nil
      # 3. Calculate new user xp
      # 4. Update level if xp is over xp_needed
      # 5. Update user in database
      # 6. Give console confirmation

      # Intialize user object.
      user = User.new(event.user.id, event.server.id)

      # If any values are nil, set them to ints for math.
      user.xp ||= 0
      user.xp_needed ||= CONFIG['level_increment']
      user.level ||= 0

      # Add message character length to the current
      # user xp.
      user.xp = user.xp + event.content.length

      # If the user has passed the required xp amount
      # to level up:
      if user.xp > user.xp_needed
        # Increase the user level.
        user.level += 1
        event.respond ":exclamation: `#{event.user.username}` leved up to level `#{user.level}!`"
        # The factor is the level scaling * the user level.
        # i.e.:
        # 1000 * 2
        # So, 2000 xp needed to get to lvl 2 at lvl 1
        level_factor = CONFIG['level_scale'] * user.level
        # Update the user's required xp.
        # Math equation: xp_needed + base increment + ( scale * user level )
        # i.e.:
        # 3000 + 1000 + 2000
        # 6000 xp needed to get to lvl 3 at lvl 2
        user.xp_needed = user.xp_needed + CONFIG['level_increment'] + level_factor
      end

      # Call the final update.
      user.update
      # Give console confirmation.
      puts "#{event.user.username}: #{user.id}, #{user.server_id} | #{user.xp} | #{user.xp_needed} | #{user.level}"
    end

    # Rank; gets user info
    command(:rank, arg_types: [Discordrb::User], bucket: :command, rate_limit_message: 'chill for %time% seconds dawg no spam pls') do | event, user_init |

      # If no user given, set user to the user that ran the command.
      user_init = event.user if user_init == nil

      # Create a new User instance.
      user = User.new(user_init.id, event.server.id)

      # Set msg.
      msg = <<-EOF
`User: #{user_init.username}`
`Server: #{event.server.name}`
:star: **|** #{user.xp} / #{user.xp_needed} XP
:mushroom: **|** Level #{user.level}
      EOF
      # Simply returning the msg says it in chat.
      msg
    end
    
    # Set the user rank
    command(:set_rank, bucket: :command, rate_limit_message: 'shut the front door for like %time% seconds dude') do | event |
      'nutshack'
    end
  end
end
