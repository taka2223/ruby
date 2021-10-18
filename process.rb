require 'nokogiri'
require 'active_support'
require 'active_support/core_ext'
require 'csv'

class Processor
    attr_accessor :status, :keywords, :body

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
        CSV.open("rating.csv","a+") do |csv|
            @body.each do |inner|
               puts name =inner.css('a').text.encode('utf-8')
               puts rate =inner.css('small.fade').text.encode('utf-8')
               puts num  =inner.css('span.tip_j').text.encode('utf-8')
            csv<<[name,rate,num]
            end
        end
    end

    def relevant_html
        parsed_page = Nokogiri::HTML(@html)
        @body = parsed_page.css('ul#browserItemList div.inner')
    end
end