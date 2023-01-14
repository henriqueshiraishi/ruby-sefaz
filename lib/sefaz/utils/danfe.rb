# frozen_string_literal: true

module SEFAZ
  module Utils
    class DANFE

      def initialize(xml)
        @tempfile = Tempfile.new(["sefaz-xml-", ".xml"])
        @tempfile.write(xml)
        @tempfile.close
      end

      def executar(openTimeout, readTimeout)
        uri = URI("https://xml.treeunfe.me")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.open_timeout = openTimeout
        http.read_timeout = readTimeout
        content  = Net::HTTP::Post::Multipart.new(uri.request_uri, file: UploadIO.new(File.new(@tempfile), 'text/xml', File.basename(@tempfile)))
        response = http.request(content)
        if response.code == "200"
          pdf_uri  = URI(JSON(response.body)['pdf'])
          return [:ok, Net::HTTP.get(pdf_uri)]
        end
        return [:error, ""]
      end

    end
  end
end
