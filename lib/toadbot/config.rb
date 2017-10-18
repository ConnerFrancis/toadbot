module Toadbot

  # Config information stored in config.yaml
  # Access with frozen constant CONFIG['key'] to get values
  module Config
    # Set some variables for setup.
    #
    # Directory is just the current directory, or the
    # folder the bot is in. bin/console runs the bot
    # from the bot master directory.
    directory = File.expand_path('.')
    # If file doesn't exist raise error.
    raise Error.new('Config', 'config.yaml does not exist. Please run bin/setup or follow manual installation.') unless File.exist?('./config/config.yaml')
    # The file we are loading is ./config/config.yaml
    file = directory + '/config/config.yaml'
    # Finally, define CONFIG constant.
    # Also freeze it. (Good practices, amirite?)
    # Also, CONFIG belongs to TOADBOT module, not Config. (Easier syntax)
    Toadbot::CONFIG = YAML.load_file(file).freeze
    # Iterate through each CONFIG pair.
    # If any are blank, throw an error.
    CONFIG.each do | key, value |
      # If a value is nil, raise an error
      raise Error.new('Config', "#{key} has an empty value.") unless value
    end
  end
end
