require 'net/http'
require 'uri'
require 'cgi'
require 'json'

require "socialinfo/version"

module Socialinfo
  class Core
    def facebook(url)
      xml = response_for "http://api.facebook.com/restserver.php?method=links.getStats&urls=#{url}"
      keys = %w{normalized_url share_count like_count comment_count total_count click_count} # comments_fbid
      keys.each.inject({}){|hash, k, v| hash[k] = $1 if xml.match(/<#{k}>(.*)<\/#{k}>/); hash }
    end
    def twitter(url)
      JSON.parse(response_for("http://urls.api.twitter.com/1/urls/count.json?url=#{url}")).reject{|k| k == 'url' }
    end
    def googleplus(url)
    end
    def all(url)
      [:facebook, :twitter].each.inject({}) {|hash, key| hash[key] = send(key, url); hash }
    end
    private
    def response_for(url)
      Net::HTTP.get_response(URI.parse(URI.encode(url))).body
    end
  end

  class CLI
    KEY_SIZE = 15
    def initialize
      @info = Core.new
    end
    def process(url)
      r = @info.all url
      puts
      puts "[Twitter]".upcase
      r[:twitter].each do |k,v|
        puts "+ #{k.rjust(KEY_SIZE)}: #{v}"
      end
      puts
      puts "[Facebook]".upcase
      r[:facebook].each do |k,v|
        puts "+ #{k.rjust(KEY_SIZE)}: #{v}"
      end
      puts
    end
  end
  
end
