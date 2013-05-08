module Openas2
  module Remote
    class Command
      attr_accessor :username, :password

      def initialize(username, password)
        @username = username
        @password = password
      end

      def build(cmd)
        %(<command id="#{@username}" password="#{@password}">#{cmd}</command>\n)
      end
        
    end
  end
end