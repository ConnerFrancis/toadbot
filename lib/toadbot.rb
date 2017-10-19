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

  # Inload, or include/load modules
  def self.inload(m)
    # Raise error if the file doesn't exist.
    raise Error.new('Inload', "#{m} does not exist!") unless File.exist?("./lib/toadbot/#{m}.rb")
    # Load module and give console confirmation.
    load "toadbot/#{m}.rb"
    puts "#{m} loaded.".green
  end

  # Internal loads
  # aka inloads
  #
  # Config
  inload('config')
  # Initial setup
  inload('init')
  # User object
  inload('user')
  # Xp module
  inload('xp')
  # Utils module
  inload('utils')
  # Miscellaneous module
  inload('misc')
  # Voice/music module
  inload('voice')
  # Admin module (eval, etc)
  inload('superadmin')
  
  BOT.run :async # Finally, run the bot
  
  # Run the console very last so everything
  # can load.
  inload('console')

end # Toadbot
