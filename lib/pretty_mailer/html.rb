require 'nokogiri'

module PrettyMailer
  
  class HTML
    
    def initialize body
      @doc = Nokogiri::HTML body
    end
    
    def add_rules selector, declarations, specificity
      if selector =~ /^[\.\#a-z]/i
        begin
          @doc.css(selector).each do |tag|
            tag['specificities'] = "#{tag['specificities']}#{specificity};"
            tag[specificity.to_s] = declarations.gsub /\s+/, ''
          end
        rescue Exception => Nokogiri::CSS::SyntaxError
          Rails.logger.debug "Ignoring invalid selector: #{selector}"
        end
      end
    end
    
    def reduce_specificities!
      tags_with_specificities.each do |tag|
        specificities_on_tag(tag).each do |specificity|
          if tag['style'].blank?
            tag['style'] = "#{ tag[specificity] }"
          else
            merge_in_styles tag, specificity
          end
          tag.delete specificity
        end
        tag.delete 'specificities'
      end
    end
    
    def to_s
      @doc.to_s
    end
    
    private
    
      def tags_with_specificities
        @doc.xpath '//*[@specificities]'
      end
    
      def specificities_on_tag tag
        tag['specificities'].split(';').sort
      end
    
      def merge_in_styles tag, specificity
        tag[specificity].split(';').each do |rule|
          tag['style'] = tag['style'].sub /#{rule.split(':').first.strip}:\s*[a-z0-9]+\s*;/i, "#{rule};"
          tag['style'] += "#{rule};" unless $~
        end
      end
    
  end
  
end