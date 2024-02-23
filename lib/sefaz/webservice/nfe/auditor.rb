# frozen_string_literal: true

module SEFAZ
  module Webservice
    module NFE
      # Auditor de XML pelo validador público da Tecnospeed
      class Auditor

        def initialize(xml)
          @xml = xml
        end
  
        def exec(openTimeout, readTimeout)
          uri = URI("https://validadornfe.tecnospeed.com.br/validar")
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = true
          http.open_timeout = openTimeout
          http.read_timeout = readTimeout
          content = Net::HTTP::Post.new(uri.request_uri)
          content.set_form_data(txtXML: @xml)
          response = http.request(content)
          if response.code == "200"
            url = JSON(response.body)["url"]
            url_esc = url.to_s.sub("{", "%7B").sub("}", "%7D")
            txt_uri = URI(url_esc)
            body = CGI.unescape(Net::HTTP.get(txt_uri))
            return [:ok, JSON(body)]
          end
          return [:error, {}]
        end
  
      end 
    end
  end
end
