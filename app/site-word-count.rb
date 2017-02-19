require 'anemone'

class Crawler

def initialize
  @body_text = []
  @crawled_links = []
  @links_to_crawl = []
  @count_hash = Hash.new
end

  def crawl(url) 
  Anemone.crawl(url) do |anemone|
    anemone.on_every_page { |page| 
      puts "looking at #{page.url}"
      @crawled_links << page.url
        titles.push page.doc.at('title').inner_html rescue nil 
        @thing = page.body.delete("\n").gsub(/<script.*?<\/script>/,"").gsub(/<.*?>/,"").gsub(/[\.\?\!\,\:\;\"\(\)\}\{\]\[]/," ").split(" ")
        @thing.each { |x|
	    @body_text << x.downcase 
         }
    }
    
  end
  @body_text.uniq.each { |x|
    @count_hash[x] = @body_text.count(x) 
  }
  end

  def take_top_words(num_words)
    @instance_ct = @count_hash.values.uniq.max(num_words)
    @top_words = @count_hash.select { |k,v| v >= @instance_ct.min }
    return @top_words
  end

end
