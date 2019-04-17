class User < ActiveRecord::Base

 has_many :gameplays
 has_many :games, through: :gameplays

   def self.register_account(username,password)
     # @user = 
     self.create(username: username, password: password)
   end

end
