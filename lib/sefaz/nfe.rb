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
      @versao = "4.00"
      _, @wsdl = SEFAZ::Utils::WSDL.get(:NfeStatusServico, @ambiente, @uf)
      @conn = SEFAZ::Utils::Connection.new(@pkcs12, @wsdl, @versao, @uf)
      return @conn.connected?
    end

    def statusDoServico
      @versao = "4.00"
      _, @wsdl = SEFAZ::Utils::WSDL.get(:NfeStatusServico, @ambiente, @uf)
      @conn = SEFAZ::Utils::Connection.new(@pkcs12, @wsdl, @versao, @uf)
      @mensagem = { consStatServ: { tpAmb: @ambiente, cUF: @uf, xServ: 'STATUS' }, attributes!: { consStatServ: { xmlns: "http://www.portalfiscal.inf.br/nfe", versao: @versao } } }
      return @conn.call(:nfe_status_servico_nf, @mensagem)
    end

    def consultarNF(chaveNF)
      @versao = "4.00"
      _, @wsdl = SEFAZ::Utils::WSDL.get(:NfeConsultaProtocolo, @ambiente, @uf)
      @conn = SEFAZ::Utils::Connection.new(@pkcs12, @wsdl, @versao, @uf)
      @mensagem = { consSitNFe: { tpAmb: @ambiente, xServ: 'CONSULTAR', chNFe: chaveNF }, attributes!: { consSitNFe: { xmlns: "http://www.portalfiscal.inf.br/nfe", versao: @versao } } }
      return @conn.call(:nfe_consulta_nf, @mensagem)
    end

    def consultarCadastro(nroDocumento, tpDocumento, uf)
      @versao = "2.00"
      _, @wsdl = SEFAZ::Utils::WSDL.get(:NfeConsultaCadastro, @ambiente, @uf)
      @conn = SEFAZ::Utils::Connection.new(@pkcs12, @wsdl, @versao, @uf)
      @mensagem = { ConsCad: { infCons: { xServ: 'CONS-CAD', UF: uf } }, attributes!: { ConsCad: { xmlns: "http://www.portalfiscal.inf.br/nfe", versao: @versao } } }
      case tpDocumento
      when 'CNPJ'; @mensagem[:ConsCad][:infCons][:CNPJ] = nroDocumento.to_s.delete("^0-9")
      when 'CPF';  @mensagem[:ConsCad][:infCons][:CPF]  = nroDocumento.to_s.delete("^0-9")
      when 'IE';   @mensagem[:ConsCad][:infCons][:IE]   = nroDocumento.to_s.delete("^0-9")
      end
      return @conn.call(:consulta_cadastro, @mensagem)
    end

  end
end
