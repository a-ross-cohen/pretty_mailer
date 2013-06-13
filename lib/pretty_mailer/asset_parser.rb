require 'css_parser'

module PrettyMailer
  
  class AssetParser < CssParser::Parser
    
    def initialize options
      super options
      options[:stylesheets].each do |stylesheet|
        load_string! Rails.application.assets.find_asset(stylesheet).to_s
      end
      self
    end
    
  end
  
end