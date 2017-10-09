module Toadbot

  # DB constant
  DB = Sequel.connect('sqlite://database.db')

  # Create Xp table if it doesn't exist
  #
  # Primary key: (user_id, server_id)
  # xp
  # level
  DB.run('CREATE TABLE IF NOT EXISTS Xp(user_id INTEGER, server_id INTEGER, xp INTEGER, xp_needed INTEGER, level INTEGER, PRIMARY KEY (user_id, server_id))')

  # XP shorthand constant for Xp table in DB
  XP = DB[:Xp]


  # Set bot to a CommandBot with the token and client_id from CONFIG
  BOT = Discordrb::Commands::CommandBot.new token: CONFIG.token, client_id: CONFIG.client_id, prefix: CONFIG.prefix

  # Buckets (rate limiting)
  BOT.bucket :command, delay: 2
end
