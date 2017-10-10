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
  # Xp module
  require 'toadbot/xp'
  # Utils module
  require 'toadbot/utils'
  # Miscillanious module
  require 'toadbot/misc'

  BOT.include! Xp

  BOT.include! Utils

  BOT.include! Misc

  BOT.run # Finally, run the bot

end # Toadbot
