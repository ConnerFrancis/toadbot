module Toadbot

  # For getting information about or updating users.
  class User
    # User id and server id should never be changed
    attr_reader :id, :server_id
    # These are what we change
    attr_accessor :xp, :xp_needed, :level

    def initialize(user_id, server_id)
      @id = user_id
      @server_id = server_id

      @xp = XP.where(:user_id => @id, :server_id => @server_id).get(:xp)
      @xp_needed = XP.where(:user_id => @id, :server_id => @server_id).get(:xp_needed)
      @level = XP.where(:user_id => @id, :server_id => @server_id).get(:level)
    end

    # Update_xp simply enters in the instance variables to the database.
    # Users are differentiated by id and server_id, so it is server specific.
    def update_xp
      XP.where(:user_id => @id, :server_id => @server_id).insert_conflict(:replace).insert(:user_id => @id, :server_id => @server_id, :xp => @xp, :xp_needed => @xp_needed, :level => @level)

      puts 'Updated user ' + @id.to_s + ', xp: ' + @xp.to_s + ', xp_needed: ' + @xp_needed.to_s + ', level: ' + @level.to_s + ', server: ' + @server_id.to_s
      # Updated user 000000, xp: 0, xp_needed: 0, level: 0, server: 00000
    end
  end
end
