require 'socket'
require 'openssl'

module Openas2
  module Remote
    class Connection

      attr_accessor :socket, :ssl_context, :ssl_socket

      def initialize(host='localhost', port=4321, ciphers=[])
        @socket = TCPSocket.new(host, port)
        @ssl_context = OpenSSL::SSL::SSLContext.new

        if OpenSSL::OPENSSL_VERSION.match('1.1')
          ciphers << ["ADH-AES256-SHA@SECLEVEL=0", "TLSv1/SSLv3", 256, 256]
        else
          ciphers << ["ADH-AES256-SHA", "TLSv1/SSLv3", 256, 256]
        end

        @ssl_context.ciphers = ciphers
        @ssl_context.max_version = OpenSSL::SSL::TLS1_2_VERSION
      end

      def connect
        @ssl_socket = OpenSSL::SSL::SSLSocket.new(@socket, @ssl_context)
        @ssl_socket.sync_close = true
        @ssl_socket.connect
      end

      def readlines
        @ssl_socket.readlines
      end

      def puts(s)
        @ssl_socket.puts(s)
      end

      def gets
        @ssl_socket.gets
      end

      def close
        @ssl_socket.close
      end

    end
  end
end
