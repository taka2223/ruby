require_relative 'request.rb'

(1..201).each do |i|
    url = "https://bangumi.tv/anime/browser?sort=rank&page=#{i}"
    a = LinkCrawler.new(url) 
    b = Processor.new(a.visit_web,url)
    b.parse_keywords
end
