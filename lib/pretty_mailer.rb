require "pretty_mailer/version"
require 'css_parser'
require 'nokogiri'

module PrettyMailer
  
  class << self
    
    def included base
      base.class_eval do
        alias_method_chain :collect_responses_and_parts_order, :inline_styles
      end
    end
    
  end
  
  def collect_responses_and_parts_order_with_inline_styles headers
    responses, parts_order = collect_responses_and_parts_order_without_inline_styles headers
    responses.map! do |response|
      if response[:content_type] == 'text/html'
        apply_inline_styles response, headers[:css]
      else
        response
      end
    end
    [responses, parts_order]
  end
  
  def apply_inline_styles response, stylesheets
    doc = Nokogiri::HTML response[:body]
    [*stylesheets].each do |stylesheet|
      parsed_css( stylesheet ).each_selector do |selector, declarations, specificity|
        doc.css( selector ).each do |tag|
          if tag['style'].blank?
            tag['style'] = "#{ declarations }"
          else
            declarations.split( ';' ).each do |rule|
              tag['style'] = tag['style'].sub /#{rule.split(':').first.strip}:\s*[a-z0-9]+\s*;/i, rule
            end
          end
        end
      end
    end
    response[:body] = doc.to_s
    response
  end
  
  def parsed_css stylesheet
    parser = CssParser::Parser.new
    parser.load_string! Rails.application.assets.find_asset( stylesheet ).to_s
    parser
  end
  
end
