module Toadbot
  
  # Utility commands/events
  module Utils
    # Extend the Event and Command container
    # 
    # Discordrb events
    extend Discordrb::EventContainer
    # Discordrb commands
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
end