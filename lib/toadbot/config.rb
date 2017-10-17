module Toadbot

  # Config information stored in config.yaml
  # Access with frozen constant CONFIG
  class Config
    # These should never have to be changed.
    attr_reader :file, :token, :client_id, :owner_id, :prefix, :level_increment, :level_scale

    def initialize
      # Base file access
      directory = File.expand_path('.')
      file = directory + '/config/config.yaml'
      puts "Config in #{file}"
      @file = YAML.load_file(file)

      # Client information
      @token = @file['token']
      @client_id = @file['client_id']
      @owner_id = @file['owner_id']
      # Raise custom errors if config token or client_id is missing
      raise Error.new('Config', 'Missing token in config.yaml'.red) if @token == nil
      raise Erorr.new('Config', 'Missing client id in config.yaml'.red) if @client_id == nil

      # Command prefix and chat confirmation
      @prefix = @file['prefix']
      puts 'Command prefix is " ' + @prefix + ' "'

      # Level and xp information
      @level_increment = @file['level_increment']
      puts 'Level increment is ' + @level_increment.to_s
      @level_scale = @file['level_scale']
      puts 'Level scaling factor is ' + @level_scale.to_s

      # Confirmation on load.
      puts 'Config loaded!'
    end
  end

  # Set Config to CONFIG
  CONFIG = Config.new.freeze
end
