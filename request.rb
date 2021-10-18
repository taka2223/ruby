require 'nokogiri'
require 'csv'
require 'httparty'
require_relative './process.rb'

class LinkCrawler
    NUM_ATTEMPTS = 20
    RESULTS_FILE = 'results.csv'
    
    def initialize(url)
        @url = url
    end

    def visit_web
        attempt = 1
        debug("#{@url}:visiting #{attempt} time ") if attempt == NUM_ATTEMPTS 
        html = get_response(@url)
    end

    def get_response(url_address)
        response = HTTParty.get(url_address)
    
        if response.code == 500
          unless url_address.include?('https')
            response = HTTParty.get(url_address.sub('http', 'https'))
            url_address.sub!('http', 'https') if response.code != 500
          end
        end
        response
      end
    def debug(message)
        puts message
    end
end
