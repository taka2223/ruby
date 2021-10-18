require 'nokogiri'
require 'active_support'
require 'active_support/core_ext'
require 'json'

class Processor
    attr_accessor :status, :keywords

    def initialize(html,url)
        @html = html
        @url_address =url
        @keywords  = []
        parse_status
    end

    private def parse_status
        @status = (@html.code==200?'SUCCESS':'FAIL(#{html.code})')
    end

    def parse_keywords
        relevant_html
        a = JSON.parse(@body)
    end

    def relevant_html
        parsed_page = Nokogiri::HTML(@html)
        @body = parsed_page.css('ul#browserItemList div.inner')
        @body.each do |inner|
            puts inner.css('a').text+' '+inner.css('small.fade') .text 
        end
    end

end