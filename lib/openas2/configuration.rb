module Openas2
  class Configuration
    attr_accessor :command, :username, :password, :host, :port, :connection

    def initialize(username, password, host, port)
      @command    = Openas2::Remote::Command.new(username, password)
      @host = host
      @port = port
    end

    def send(cmd)
      @connection = Openas2::Remote::Connection.new(@host, @port)
      @connection.connect
      cmd = @command.build cmd
      puts cmd
      @connection.puts(cmd)
      # also parse attributes into hash
      # Hash[*s.gsub(/{|}|\s/, '').split(",").map{|a|a.split('=')}.flatten]
      r = "<results>#{@connection.readlines.join}</results>"
      @connection.close
      r
    end

    def partner(name)
      partner = send("partner view #{name}")
      xml=Nokogiri::XML(partner)
      xml.xpath('//result').map &:text
    end

    def partners
      list = send("partner list")
      xml=Nokogiri::XML(list)
      xml.xpath('//result').map &:text
    end

    def add_partner(as2_id, email, name, x509_alias)
      params = "as2_id=#{as2_id} email=#{email} name=#{name} x509_alias=#{x509_alias}"
      send("partner add #{params}")
    end

    def remove_partner(name)
      params = "partner delete #{name}"
      send("partner delete #{params}")
    end

  end
end