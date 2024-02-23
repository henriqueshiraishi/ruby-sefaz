# frozen_string_literal: true

module SEFAZ
  module Webservice
    module NFE
      # Validador de XML pelo validador público da SEFAZ-RS
      class Validator
  
        def initialize(xml)
          @xml = xml
        end
  
        def exec(openTimeout, readTimeout)
          uri = URI("https://www.sefaz.rs.gov.br/NFE/NFE-VAL.aspx")
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = true
          http.open_timeout = openTimeout
          http.read_timeout = readTimeout
          content = Net::HTTP::Post.new(uri.request_uri)
          content.set_form_data(txtxml: @xml)
          response = http.request(content)
          if response.code == "200"
            nodes = Nokogiri::HTML(response.body.force_encoding('utf-8')).css('.tabela_resultado li').to_a
            mensagens = {}
            falhas = {}
            nodes[0..2].each do |node|
              k = get_key(node)
              v = get_message(node)
              mensagens[k] = v
                 falhas[k] = v if node.to_s.include?('../Imagens/erro.png')
            end
            return [:ok, mensagens, falhas]
          end
          return [:error, {}, {}]
        end
  
        private
  
          def get_key(node)
            if node.elements[0].to_s.include?('<a href=')
              "Schema XML"
            else
              node.elements[1].text.to_s.delete(':').strip
            end
          end
  
          def get_message(node)
            if node.elements[0].to_s.include?('<a href=')
              contents = []
              node.elements[1].elements.each do |el|
                contents.push(el.text.to_s.strip)
              end
              return contents
            else
              key = node.elements[1].text.to_s
              return [node.text.to_s.sub(key, '').strip]
            end
          end
  
      end
    end
  end
end
