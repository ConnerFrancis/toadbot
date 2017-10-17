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
  # Colored console msgs
  require 'colored'

  # Internal requires
  #
  # Error custom msg
  require 'toadbot/error'
  # Config
  require 'toadbot/config'
  # Initial setup
  require 'toadbot/init'
  # User object
  require 'toadbot/user'
  # Xp module
  require 'toadbot/xp'
  BOT.include! Xp
  # Utils module
  require 'toadbot/utils'
  BOT.include! Utils
  # Miscellaneous module
  require 'toadbot/misc'
  BOT.include! Misc
  # Voice/music module
  require 'toadbot/voice'
  BOT.include! Voice
  # Admin module (eval, etc)
  require 'toadbot/superadmin'
  BOT.include! SuperAdmin

  BOT.run # Finally, run the bot

end # Toadbot
