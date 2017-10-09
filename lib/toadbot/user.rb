module Toadbot

  # For getting information about or updating users.
  class User
    attr_reader :id
    attr_accessor :xp
    attr_accessor :xp_needed
    attr_accessor :level
    attr_reader :server_id
    
    def initialize(user_id, server_id)
      @id = user_id
      @server_id = server_id
      
      @xp = XP.where(:user_id => @id, :server_id => @server_id).get(:xp)
      @xp_needed = XP.where(:user_id => @id, :server_id => @server_id).get(:xp_needed)
      @level = XP.where(:user_id => @id, :server_id => @server_id).get(:level)
    end
    
    def update_xp
      XP.where(:user_id => @id, :server_id => @server_id).insert_conflict(:replace).insert(:user_id => @id, :server_id => @server_id, :xp => @xp, :xp_needed => @xp_needed, :level => @level)
      
      puts 'Updated user ' + @id.to_s + ', xp: ' + @xp.to_s + ', xp_needed: ' + @xp_needed.to_s + ', level: ' + @level.to_s + ', server: ' + @server_id.to_s
      # Updated user 000000, xp: 3000, level: 1
    end
  end
end