# frozen_string_literal: true

module SEFAZ
  module Utils
    # Classe base de conexão SOAP da biblioteca
    class Connection

      def initialize(pkcs12, wsdl, soap_header)
        @conn = Savon.client(
          wsdl:                       wsdl,
          ssl_verify_mode:            :none,
          ssl_cert:                   pkcs12.certificate,
          ssl_cert_key:               pkcs12.key,
          soap_header:                soap_header,
          soap_version:               2,
          convert_request_keys_to:    :none,
          convert_response_tags_to:   lambda { |key| key.to_sym },
          namespace_identifier:       nil
        )
      end
  
      def connected?; (@conn.operations.length > 0) end
      def operations; (@conn.operations) end

      def build(operation, hash)
        @conn.build_request(operation, message: hash)
      end
  
      def call(operation, hash)
        @conn.call(operation, message: hash)
      end
  
    end
  end
end
