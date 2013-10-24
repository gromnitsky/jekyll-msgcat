require 'andand'
require 'safe_yaml'

require_relative "msgcat/version"

module Jekyll
  module Msgcat
    MSGCAT_DB = '_msgcat.yaml'
    @@__msgcat = nil

    # Return a hash of parsed messge catalog or nil.
    def __get_msgcat
      return @@__msgcat if @@__msgcat

      begin
        @@__msgcat = YAML.load_file MSGCAT_DB, :safe => false
      rescue
        $stderr.puts "msgcat warning: #{MSGCAT_DB} not found"
        return nil
      end

      @@__msgcat
    end

    def __get_site
      @context.registers[:site].config
    end

    # Return a string ('lt', for example) or nil.
    def __get_locale
      __get_site.andand['msgcat'].andand['locale']
    end

    # Extract localized version of 'input' from message catalog or
    # return the original if no localization was found.
    def mc input
      locale = __get_locale || (return input)
      msgcat = __get_msgcat || (return input)

      if !msgcat[locale]
        $stderr.puts "msgcat warning: '#{locale}' wasn't found in #{MSGCAT_DB}"
        return input
      end

      (msg = msgcat[locale][input]) ? msg : input
    end

    def cur_page_in_another_locale targetLocale, cssClass = 'btn btn-primary btn-xs'
      raise 'target locale requred' if targetLocale =~ /^\s*$/

      site = __get_site
      pattern = "<a href='%s' class='#{cssClass} %s'>#{targetLocale}</a>"
      locale = __get_locale || 'en'

      # current site
      return pattern % ['#', 'disabled'] if locale == targetLocale

      deploy = site.andand['msgcat'].andand['deploy'] || 'domain'

      if deploy == 'domain'
        begin
          uri = URI site['url']
        rescue
          raise "invalid 'url' property in _config.yml: #{$!}"
        end
        host = uri.host.split '.'
        host[0] = targetLocale
        uri.host = host.join '.'
      else
        raise "no 'baseurl' property in _config.yml" unless site['baseurl']
        uri = site['baseurl'].split '/'
        if uri.size == 0
          uri = ['', targetLocale]
        else
          uri[uri.size-1] = targetLocale
        end
        uri = uri.join '/'
      end

      return pattern % [uri + @context.registers[:page]['url'], ""]
    end

  end
end
