# frozen_string_literal: true

module SEFAZ
  class NFE

    SERVICES = %i[ setaAmbiente setaRespTecnico setaPFXTss setaPFXAss statusDoServico consultarNF consultarCadastro consultarRecibo
                   assinarNF validarNF auditarNF gerarDANFE inutilizarNF calculaChaveInutilizacao exportarInutilizarNF enviarInutilizarNF ]

    def initialize
    end

    def setaAmbiente(params = {})
      @uf = params[:uf]
      @ambiente = params[:ambiente]
    end

    def setaRespTecnico(params = {})
      @cnpjTec = params[:cnpj]
      @contatoTec = params[:contato]
      @emailTec = params[:email]
      @foneTec = params[:fone]
      @idCSRT = params[:idCSRT]
      @CSRT = params[:CSRT]
    end

    def setaPFXTss(params = {})
      @pkcs12Tss = OpenSSL::PKCS12.new(params[:pfx], params[:senha])
    end

    def setaPFXAss(params = {})
      @pkcs12Ass = OpenSSL::PKCS12.new(params[:pfx], params[:senha])
    end

    # Consulta Status SEFAZ
    def statusDoServico
      versao = "4.00"
      hash = { consStatServ: { tpAmb: @ambiente, cUF: @uf, xServ: 'STATUS', :@xmlns => "http://www.portalfiscal.inf.br/nfe", :@versao => versao } }
      wsdl = SEFAZ::Utils::WSDL.get(:NfeStatusServico, @ambiente, @uf)
      conn = SEFAZ::Utils::Connection.new(@pkcs12Tss, wsdl, versao, @uf)
      resp = conn.call(:nfe_status_servico_nf, hash)
      return [SEFAZ.to_xml(resp.body), resp.body]
    end

    # Consulta Situação NF
    # @chaveNF(String) = Chave de acesso de uma NF
    def consultarNF(chaveNF)
      versao = "4.00"
      hash = { consSitNFe: { tpAmb: @ambiente, xServ: 'CONSULTAR', chNFe: chaveNF, :@xmlns => "http://www.portalfiscal.inf.br/nfe", :@versao => versao } }
      wsdl = SEFAZ::Utils::WSDL.get(:NfeConsultaProtocolo, @ambiente, @uf)
      conn = SEFAZ::Utils::Connection.new(@pkcs12Tss, wsdl, versao, @uf)
      resp = conn.call(:nfe_consulta_nf, hash)
      return [SEFAZ.to_xml(resp.body), resp.body]
    end

    # Consulta Cadastro
    # @nroDocumento(String) = Número do documento
    # @tpDocumento(String)  = CNPJ/CPF/IE
    # @uf(String) = Sigla do estado que será consultado (SP; MG; RJ; ...)
    def consultarCadastro(nroDocumento, tpDocumento, uf)
      versao = "2.00"
      hash = { ConsCad: { infCons: { xServ: 'CONS-CAD', UF: uf }, :@xmlns => "http://www.portalfiscal.inf.br/nfe", :@versao => versao } }
      case tpDocumento
      when 'CNPJ'; hash[:ConsCad][:infCons][:CNPJ] = nroDocumento.to_s.delete("^0-9")
      when 'CPF';  hash[:ConsCad][:infCons][:CPF]  = nroDocumento.to_s.delete("^0-9")
      when 'IE';   hash[:ConsCad][:infCons][:IE]   = nroDocumento.to_s.delete("^0-9")
      end
      wsdl = SEFAZ::Utils::WSDL.get(:NfeConsultaCadastro, @ambiente, @uf)
      conn = SEFAZ::Utils::Connection.new(@pkcs12Tss, wsdl, versao, @uf)
      resp = conn.call(:consulta_cadastro, hash)
      return [SEFAZ.to_xml(resp.body), resp.body]
    end

    # Consulta Recebido de Lote
    # @numRecibo(String) = Número do recibo do lote de NF-e
    def consultarRecibo(numRecibo)
      versao = "4.00"
      hash = { consReciNFe: { tpAmb: @ambiente, nRec: numRecibo, :@xmlns => "http://www.portalfiscal.inf.br/nfe", :@versao => versao } }
      wsdl = SEFAZ::Utils::WSDL.get(:NFeRetAutorizacao, @ambiente, @uf)
      conn = SEFAZ::Utils::Connection.new(@pkcs12Tss, wsdl, versao, @uf)
      resp = conn.call(:nfe_ret_autorizacao_lote, hash)
      return [SEFAZ.to_xml(resp.body), resp.body]
    end

    # Assinar NF - PFX de assinatura - Certificado A1
    # @documento(Hash ou String) = XML ou HASH que será assinado
    def assinarNF(documento)
      hash = (documento.is_a?(Hash) ? documento : SEFAZ.to_hash(documento))

      uri             = "#" + (hash.dig(:NFe, :infNFe, :@Id) || hash.dig(:inutNFe, :infInut, :@Id) || hash.dig(:evento, :infEvento, :@Id)).to_s
      digestValue     = OpenSSL::Digest::SHA1.digest(SEFAZ.to_xml(hash[hash.keys.first]))
      signatureValue  = @pkcs12Ass.key.sign(OpenSSL::Digest::SHA1.new, SEFAZ.to_xml(hash[hash.keys.first]))
      x509Certificate = @pkcs12Ass.certificate.to_pem.gsub(/\-\-\-\-\-[A-Z]+ CERTIFICATE\-\-\-\-\-/, "").gsub(/\n/,"")

      hash[hash.keys.first][:Signature] = {
        :@xmlns => "http://www.w3.org/2000/09/xmldsig#",
        SignedInfo: {
          CanonicalizationMethod: { :@Algorithm => "http://www.w3.org/TR/2001/REC-xml-c14n-20010315" },
          SignatureMethod: { :@Algorithm => "http://www.w3.org/2000/09/xmldsig#rsa-sha1" },
          Reference: { :@URI => uri,
            Transforms: {
              Transform: { :@Algorithm => "http://www.w3.org/TR/2001/REC-xml-c14n-20010315" },
              Transform: { :@Algorithm => "http://www.w3.org/2000/09/xmldsig#enveloped-signature" }
            },
            DigestMethod: { :@Algorithm => "http://www.w3.org/2000/09/xmldsig#sha1" },
            DigestValue: Base64.strict_encode64(digestValue)
          }
        },
        SignatureValue: Base64.strict_encode64(signatureValue),
        KeyInfo: {
          X509Data: {
            X509Certificate: x509Certificate
          }
        }
      }
      return [SEFAZ.to_xml(hash), hash]
    end

    # Valida NF no SEFAZ RS NF-e (https://www.sefaz.rs.gov.br/NFE/NFE-VAL.aspx)
    # @documento(Hash ou String) = XML ou HASH que será validado
    # @openTimeout(Integer) = Tempo de espera em segundos para abrir conexão (opcional: padrão 60)
    # @readTimeout(Integer) = Tempo de espera em segundos para ler resposta (opcional: padrão 60)
    def validarNF(documento, openTimeout = 60, readTimeout = 60)
      xml = (documento.is_a?(Hash) ? SEFAZ.to_xml(documento) : documento)
      validador = SEFAZ::Utils::Validador.new(xml)
      stat, msg, err = validador.executar(openTimeout, readTimeout)
      case stat
      when :ok; return [true, msg, err]
      else      return [false, {}, {}]
      end
    end

    # Auditar NF no validador TecnoSpeed (https://validador.nfe.tecnospeed.com.br/)
    # @documento(Hash ou String) = XML ou HASH que será auditado
    # @openTimeout(Integer) = Tempo de espera em segundos para abrir conexão (opcional: padrão 60)
    # @readTimeout(Integer) = Tempo de espera em segundos para ler resposta (opcional: padrão 60)
    def auditarNF(documento, openTimeout = 60, readTimeout = 60)
      xml = (documento.is_a?(Hash) ? SEFAZ.to_xml(documento) : documento)
      auditor = SEFAZ::Utils::Auditor.new(xml)
      stat, msg = auditor.executar(openTimeout, readTimeout)
      case stat
      when :ok; return [true, msg]
      else      return [false, {}]
      end
    end

    # Gerar DANFE pelo FreeNFe (https://www.freenfe.com.br/leitor-de-xml-online)
    # @documento(Hash ou String) = XML ou HASH que será gerado
    # @openTimeout(Integer) = Tempo de espera em segundos para abrir conexão (opcional: padrão 60)
    # @readTimeout(Integer) = Tempo de espera em segundos para ler resposta (opcional: padrão 60)
    def gerarDANFE(documento, openTimeout = 60, readTimeout = 60)
      xml = (documento.is_a?(Hash) ? SEFAZ.to_xml(documento) : documento)
      gerador = SEFAZ::Utils::DANFE.new(xml)
      stat, pdf = gerador.executar(openTimeout, readTimeout)
      case stat
      when :ok; return [true, pdf]
      else      return [false, ""]
      end
    end

    # Inutilizar NF - Gera, assina e envia o documento com certificado A1 (exportarInutilizarNF, assinarNF, enviarInutilizarNF)
    # OBS: Caso parâmetro @chaveNF estiver em branco, a chave será calculada automaticamente (calculaChaveInutilizacao)
    # @chaveNF = Identificador da TAG a ser assinada
    # @ano = Ano de inutilização da numeração
    # @cnpj = CNPJ do emitente
    # @modelo = Modelo do documento (55 ou 65)
    # @serie = Série da NF-e
    # @nroNFIni = Número da NF-e inicial a ser inutilizada
    # @nroNFFin = Número da NF-e final a ser inutilizada
    # @justificativa = Informar a justificativa do pedido de inutilização
    def inutilizarNF(chaveNF, ano, cnpj, modelo, serie, nroNFIni, nroNFFin, justificativa)
      _, hash = exportarInutilizarNF(chaveNF, ano, cnpj, modelo, serie, nroNFIni, nroNFFin, justificativa)
      _, hash = assinarNF(hash)
      return enviarInutilizarNF(hash)
    end

    # Calcular Chave de Inutilização
    # @ano = Ano de inutilização da numeração
    # @cnpj = CNPJ do emitente
    # @modelo = Modelo do documento (55 ou 65)
    # @serie = Série da NF-e
    # @nroNFIni = Número da NF-e inicial a ser inutilizada
    # @nroNFFin = Número da NF-e final a ser inutilizada
    def calculaChaveInutilizacao(ano, cnpj, modelo, serie, nroNFIni, nroNFFin)
      serie = serie.to_s.rjust(3, "0")
      nroNFIni = nroNFIni.to_s.rjust(9, "0")
      nroNFFin = nroNFFin.to_s.rjust(9, "0")
      return "ID#{@uf}#{ano}#{cnpj}#{modelo}#{serie}#{nroNFIni}#{nroNFFin}"
    end

    # Exportar Inutilização NF - Exporta um documento bruto (sem assinatura)
    # OBS: Recomendado quando utilizado o certificado A3
    #      Caso parâmetro @chaveNF estiver em branco, a chave será calculada automaticamente (calculaChaveInutilizacao)
    # @chaveNF = Identificador da TAG a ser assinada
    # @ano = Ano de inutilização da numeração
    # @cnpj = CNPJ do emitente
    # @modelo = Modelo do documento (55 ou 65)
    # @serie = Série da NF-e
    # @nroNFIni = Número da NF-e inicial a ser inutilizada
    # @nroNFFin = Número da NF-e final a ser inutilizada
    # @justificativa = Informar a justificativa do pedido de inutilização
    def exportarInutilizarNF(chaveNF, ano, cnpj, modelo, serie, nroNFIni, nroNFFin, justificativa)
      versao  = "4.00"
      chaveNF = calculaChaveInutilizacao(ano, cnpj, modelo, serie, nroNFIni, nroNFFin) if chaveNF.blank?
      hash = { inutNFe: { :@xmlns => "http://www.portalfiscal.inf.br/nfe", :@versao => versao, infInut: {
        :@Id => chaveNF,
        tpAmb:  @ambiente,
        xServ:  'INUTILIZAR',
        cUF:    @uf,
        ano:    ano,
        CNPJ:   cnpj,
        mod:    modelo,
        serie:  serie,
        nNFIni: nroNFIni,
        nNFFin: nroNFFin,
        xJust:  justificativa
      } } }
      return [SEFAZ.to_xml(hash), hash]
    end

    # Enviar Inutilização NF - Necessário um documento assinado
    # OBS: Recomendado quando utilizado o certificado A3
    # @documento(Hash ou String) = XML ou HASH assinado que será enviado
    def enviarInutilizarNF(documento)
      versao = "4.00"
      hash = (documento.is_a?(Hash) ? documento : SEFAZ.to_hash(documento))
      wsdl = SEFAZ::Utils::WSDL.get(:NfeInutilizacao, @ambiente, @uf)
      conn = SEFAZ::Utils::Connection.new(@pkcs12Tss, wsdl, versao, @uf)
      resp = conn.call(:nfe_inutilizacao_nf, hash)
      return [SEFAZ.to_xml(resp.body), resp.body]
    end

    # Gera Informações do Responsável Técnico - Calcula o hashCSRT e cria o grupo do responsável técnico
    # Necessário quando estiver emitindo uma NF-e/NFC-e - Acionado automáticamente na emissão da NF
    # @chaveNF(String) = Chave de acesso de uma NF
    def gerarInfRespTec(chaveNF)
      concat = @CSRT.to_s + chaveNF.to_s
      hexdigest = Digest::SHA1.hexdigest(concat)
      hashCSRT  = Base64.strict_encode64(hexdigest)
      hash = { infRespTec: { CNPJ: @cnpjTec, xContato: @contatoTec, email: @emailTec, fone: @foneTec, idCSRT: @idCSRT, hashCSRT: hashCSRT } }
      return [SEFAZ.to_xml(hash), hash]
    end

  end
end
