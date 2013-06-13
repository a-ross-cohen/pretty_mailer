require "pretty_mailer/version"
require "pretty_mailer/html"
require "pretty_mailer/asset_parser"

module PrettyMailer
  
  class << self
    
    def included base
      base.alias_method_chain :collect_responses_and_parts_order, :inline_styles
    end
    
  end
  
  def collect_responses_and_parts_order_with_inline_styles headers
    responses, parts_order = collect_responses_and_parts_order_without_inline_styles headers
    unless headers[:css].blank?
      responses.map! do |response|
        if response[:content_type] == 'text/html'
          apply_inline_styles response, headers[:css]
        else
          response
        end
      end
    end
    [responses, parts_order]
  end
  
  def apply_inline_styles response, stylesheets
    body = HTML.new response[:body]
    AssetParser.new(stylesheets: [*stylesheets]).each_selector do |selector, declarations, specificity|
      body.add_rules selector, declarations, specificity
    end
    body.reduce_specificities!
    response[:body] = body.to_s
    response
  end
  
end
