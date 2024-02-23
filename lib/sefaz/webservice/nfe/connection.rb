# frozen_string_literal: true

module SEFAZ
  module Webservice
    module NFE
      # Principal classe de conexão SOAP com o módulo NF-e/NFC-e
      class Connection < SEFAZ::Utils::Connection

        def initialize(pkcs12, wsdl, versaoDados, cUF)
          @soap_header = { nfeCabecMsg: { versaoDados: versaoDados, cUF: cUF, :@xmlns => 'http://www.portalfiscal.inf.br/nfe' } }
          super(pkcs12, wsdl, @soap_header)
        end

      end
    end
  end
end
