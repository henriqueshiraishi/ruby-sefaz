# frozen_string_literal: true

module SEFAZ
  class NFE

    SERVICES = %i[ connected? statusDoServico ]

    def initialize(ambiente, uf, pfx, senha)
      @pkcs12   = OpenSSL::PKCS12.new(pfx, senha)
      @ambiente = ambiente
      @uf       = uf
    end

    def connected?
      @versao, @wsdl = SEFAZ::Utils::WSDL.get(:NfeStatusServico, @ambiente, @uf)
      @conn = SEFAZ::Utils::Connection.new(@pkcs12, @wsdl, @versao, @uf)
      return @conn.connected?
    end

    def statusDoServico
      @versao, @wsdl = SEFAZ::Utils::WSDL.get(:NfeStatusServico, @ambiente, @uf)
      @conn = SEFAZ::Utils::Connection.new(@pkcs12, @wsdl, @versao, @uf)
      @mensagem = { consStatServ: { tpAmb: @ambiente, cUF: @uf, xServ: 'STATUS' }, attributes!: { consStatServ: { xmlns: "http://www.portalfiscal.inf.br/nfe", versao: @versao } } }
      return @conn.call(:nfe_status_servico_nf, @mensagem)
    end

  end
end
