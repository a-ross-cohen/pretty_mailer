require 'css_parser'

module PrettyMailer
  
  class AssetParser < CssParser::Parser
    
    def initialize options
      super options
      load_string! Rails.application.assets.find_asset(options[:name]).to_s
      self
    end
    
  end
  
end