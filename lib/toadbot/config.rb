module Toadbot

  # Config information stored in config.yaml
  # Access with frozen constant CONFIG
  class Config
    attr_reader :file
    attr_reader :token
    attr_reader :client_id
    attr_reader :prefix
    attr_reader :level_increment
    attr_reader :level_scale

    def initialize
      # Base file access
      @file = YAML.load_file(__dir__ + '/config.yaml')
      @client = YAML.load_file(__dir__ + '/client.yaml')

      # Client information
      @token = @client['token']
      @client_id = @client['client_id']

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
  CONFIG = Config.new
end
