# frozen_string_literal: true

module SEFAZ
  class NFE

    SERVICES = %i[ setaAmbiente setaPFXTss setaPFXAss statusDoServico consultarNF consultarCadastro ]

    def initialize
    end

    def setaAmbiente(params = {})
      @uf = params[:uf]
      @ambiente = params[:ambiente]
    end

    def setaPFXTss(params = {})
      @pkcs12Tss = OpenSSL::PKCS12.new(params[:pfx], params[:senha])
    end

    def setaPFXAss(params = {})
      @pkcs12Ass = OpenSSL::PKCS12.new(params[:pfx], params[:senha])
    end

    # Consulta Status SEFAZ
    def statusDoServico
      @versao = "4.00"
      @hash = { consStatServ: { tpAmb: @ambiente, cUF: @uf, xServ: 'STATUS' }, attributes!: { consStatServ: { xmlns: "http://www.portalfiscal.inf.br/nfe", versao: @versao } } }
      @wsdl = SEFAZ::Utils::WSDL.get(:NfeStatusServico, @ambiente, @uf)
      @conn = SEFAZ::Utils::Connection.new(@pkcs12Tss, @wsdl, @versao, @uf)
      return @conn.call(:nfe_status_servico_nf, @hash)
    end

    # Consulta Situação NF
    # @chaveNF(String) = Chave de acesso de uma NF
    def consultarNF(chaveNF)
      @versao = "4.00"
      @hash = { consSitNFe: { tpAmb: @ambiente, xServ: 'CONSULTAR', chNFe: chaveNF }, attributes!: { consSitNFe: { xmlns: "http://www.portalfiscal.inf.br/nfe", versao: @versao } } }
      @wsdl = SEFAZ::Utils::WSDL.get(:NfeConsultaProtocolo, @ambiente, @uf)
      @conn = SEFAZ::Utils::Connection.new(@pkcs12Tss, @wsdl, @versao, @uf)
      return @conn.call(:nfe_consulta_nf, @hash)
    end

    # Consulta Cadastro
    # @nroDocumento(String) = Número do documento
    # @tpDocumento(String)  = CNPJ/CPF/IE
    # @uf(String) = Sigla do estado que será consultado (SP; MG; RJ; ...)
    def consultarCadastro(nroDocumento, tpDocumento, uf)
      @versao = "2.00"
      @hash = { ConsCad: { infCons: { xServ: 'CONS-CAD', UF: uf } }, attributes!: { ConsCad: { xmlns: "http://www.portalfiscal.inf.br/nfe", versao: @versao } } }
      case tpDocumento
      when 'CNPJ'; @hash[:ConsCad][:infCons][:CNPJ] = nroDocumento.to_s.delete("^0-9")
      when 'CPF';  @hash[:ConsCad][:infCons][:CPF]  = nroDocumento.to_s.delete("^0-9")
      when 'IE';   @hash[:ConsCad][:infCons][:IE]   = nroDocumento.to_s.delete("^0-9")
      end
      @wsdl = SEFAZ::Utils::WSDL.get(:NfeConsultaCadastro, @ambiente, @uf)
      @conn = SEFAZ::Utils::Connection.new(@pkcs12Tss, @wsdl, @versao, @uf)
      return @conn.call(:consulta_cadastro, @hash)
    end

    # Consulta Recebido de Lote
    # @numRecibo(String) = Número do recibo do lote de NF-e
    def consultarRecibo(numRecibo)
      @versao = "4.00"
      @hash = { consReciNFe: { tpAmb: @ambiente, nRec: numRecibo }, attributes!: { consReciNFe: { xmlns: "http://www.portalfiscal.inf.br/nfe", versao: @versao } } }
      @wsdl = SEFAZ::Utils::WSDL.get(:NFeRetAutorizacao, @ambiente, @uf)
      @conn = SEFAZ::Utils::Connection.new(@pkcs12Tss, @wsdl, @versao, @uf)
      return @conn.call(:nfe_ret_autorizacao_lote, @hash)
    end

  end
end
