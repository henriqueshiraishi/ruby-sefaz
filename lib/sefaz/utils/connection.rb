# frozen_string_literal: true

module SEFAZ
  module Utils
    class Connection

      def initialize(pkcs12, wsdl, versao, uf)
        @pkcs12     = pkcs12
        @wsdl       = wsdl
        @versao     = versao
        @uf         = uf
        @conn       = Savon.client(
          wsdl:                       @wsdl,
          ssl_verify_mode:            :none,
          ssl_cert:                   @pkcs12.certificate,
          ssl_cert_key:               @pkcs12.key,
          soap_header:                { nfeCabecMsg: { versaoDados: @versao, cUF: @uf }, attributes!: { nfeCabecMsg: { xmlns: "http://www.portalfiscal.inf.br/nfe" } } },
          soap_version:               2,
          convert_request_keys_to:    :none,
          namespace_identifier:       nil
        )
      end
  
      def connected?; (@conn.operations.length > 0) end
      def operations; (@conn.operations) end
      def get_connection; @conn end

      def build(servico, mensagem)
        request = @conn.build_request(servico, message: mensagem)
        request.body
      end
  
      def call(servico, mensagem)
        response = @conn.call(servico, message: mensagem)
        response.body
      end
  
    end
  end
end
