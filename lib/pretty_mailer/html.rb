require 'nokogiri'

module PrettyMailer
  
  class HTML
    
    def initialize body
      @doc = Nokogiri::HTML body
    end
    
    def add_rules selector, declarations, specificity
      @doc.css(selector).each do |tag|
        tag['specificities'] = "#{tag['specificities']}#{specificity};"
        tag[specificity.to_s] = declarations
      end
    end
    
    def reduce_specificities!
      @doc.xpath("//*[@specificities]").each do |tag|
        tag['specificities'].split(';').sort.each do |specificity|
          if tag['style'].blank?
            tag['style'] = "#{ tag[specificity] }"
          else
            tag[specificity].split(';').each do |rule|
              tag['style'] = tag['style'].sub /#{rule.split(':').first.strip}:\s*[a-z0-9]+\s*;/i, rule
            end
          end
          tag.delete specificity
        end
        tag.delete 'specificities'
      end
    end
    
    def to_s
      @doc.to_s
    end
    
  end
  
end