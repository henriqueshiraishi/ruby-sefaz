# frozen_string_literal: true

module SEFAZ
  module Webservice
    module NFE
      # Principal classe de integração com o módulo NF-e/NFC-e
      class Client < SEFAZ::Webservice::Base

        SERVICES = %i[ setaAmbiente setaRespTecnico setaPFXTss setaPFXAss statusDoServico consultarNF consultarCadastro consultarRecibo
                       assinarNF validarNF auditarNF inutilizarNF exportarInutilizarNF enviarInutilizarNF calculaChaveInutilizacao
                       enviarEvento enviarLoteDeEvento cancelarNF exportarCancelarNF enviarCCe exportarCCe enviarNF enviarLoteNF calculaChaveNF]
    
        # Métodos de Configuração:
        # - setaAmbiente
        # - setaRespTecnico
        # - setaPFXTss
        # - setaPFXAss
    
        # Métodos de Consulta, Validação e Documentos: (SEM ASSINATURA)
        # - statusDoServico
        # - consultarNF
        # - consultarCadastro
        # - consultarRecibo
        # - consultarGTIN                 (PENDENTE)
        # - consultarDistribuicaoDFe      (PENDENTE)
        # - consultarDistribuicaoDFeChave (PENDENTE)
        # - validarNF
        # - auditarNF
    
        # Métodos de Manipulação: (MAIORIA EXIGE ASSINATURA)
        # -- Os métodos 'enviarNF' e 'enviarLoteNF' não precisa 'exportar', pois os dados são montados externo à gema (XML ou Hash ou Dataset)
        # - assinarNF
        # - enviarNF
        # - enviarLoteNF
        # - calculaChaveNF
        # - inutilizarNF
        #   - exportarInutilizarNF
        #   - enviarInutilizarNF
        #   - calculaChaveInutilizacao 
        # - cancelarNF                  (EVENTO)
        #   - exportarCancelarNF        (EVENTO)
        # - enviarCCe                   (EVENTO)
        #   - exportarCCe               (EVENTO)
        # - enviarManifestacao          (PENDENTE) (EVENTO)
        #   - exportarManifestacao      (PENDENTE) (EVENTO)
        # - enviarEvento
        # - enviarLoteDeEvento
        # - gerarLeiauteEvento          (PRIVADO)
    
        def initialize
        end
    
        def setaAmbiente(params = {})
          @uf = params[:uf]
          @ambiente = params[:ambiente]
          @cnpj = params[:cnpj].to_s.delete("^0-9")
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
          wsdl = SEFAZ::Webservice::NFE::WSDL.get(:NfeStatusServico, @ambiente, @uf)
          conn = SEFAZ::Webservice::NFE::Connection.new(@pkcs12Tss, wsdl, versao, @uf)
          resp = conn.call(:nfe_status_servico_nf, hash)
          return [resp.body.to_xml!, resp.body]
        end
    
        # Consulta Situação NF
        # @chaveNF(String) = Chave de acesso de uma NF
        def consultarNF(chaveNF)
          versao = "4.00"
          hash = { consSitNFe: { tpAmb: @ambiente, xServ: 'CONSULTAR', chNFe: chaveNF, :@xmlns => "http://www.portalfiscal.inf.br/nfe", :@versao => versao } }
          wsdl = SEFAZ::Webservice::NFE::WSDL.get(:NfeConsultaProtocolo, @ambiente, @uf)
          conn = SEFAZ::Webservice::NFE::Connection.new(@pkcs12Tss, wsdl, versao, @uf)
          resp = conn.call(:nfe_consulta_nf, hash)
          return [resp.body.to_xml!, resp.body]
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
          wsdl = SEFAZ::Webservice::NFE::WSDL.get(:NfeConsultaCadastro, @ambiente, @uf)
          conn = SEFAZ::Webservice::NFE::Connection.new(@pkcs12Tss, wsdl, versao, @uf)
          resp = conn.call(:consulta_cadastro, hash)
          return [resp.body.to_xml!, resp.body]
        end
    
        # Consulta Recebido de Lote
        # @numRecibo(String) = Número do recibo do lote de NF-e
        def consultarRecibo(numRecibo)
          versao = "4.00"
          hash = { consReciNFe: { tpAmb: @ambiente, nRec: numRecibo, :@xmlns => "http://www.portalfiscal.inf.br/nfe", :@versao => versao } }
          wsdl = SEFAZ::Webservice::NFE::WSDL.get(:NFeRetAutorizacao, @ambiente, @uf)
          conn = SEFAZ::Webservice::NFE::Connection.new(@pkcs12Tss, wsdl, versao, @uf)
          resp = conn.call(:nfe_ret_autorizacao_lote, hash)
          return [resp.body.to_xml!, resp.body]
        end
    
        # Assinar NF - PFX de assinatura - Certificado A1
        # @documento(Hash ou String) = XML ou HASH que será assinado
        def assinarNF(documento)
          xml = (documento.is_a?(Hash) ? documento.to_xml! : documento)
          doc = SEFAZ::Utils::Signer.new(xml)
          doc.sign!(@pkcs12Ass.certificate, @pkcs12Ass.key)
          xml = doc.to_xml
          return [xml, xml.to_hash!]
        end
    
        # Enviar NF - Necessário uma NF assinada
        # @documento(Hash ou String) = XML ou HASH assinado que será enviado
        # @indSinc(String) = "0"=Assíncrono / "1"=Síncrono
        # @idLote(String) = Identificador de controle do Lote de envio do Lote
        def enviarNF(documento, indSinc, idLote)
          return enviarLoteNF([ documento ], indSinc, idLote)
        end
    
        # Envia Lote de NF - Necessário que cada NF esteja assinada
        # OBS: Recomendado para envio em lote de NF, cada elemento do Array pode ser Hash ou XML assinados
        # @lote(Array) = Array de NF assinadas
        # @indSinc(String) = "0"=Assíncrono / "1"=Síncrono
        # @idLote(String) = Identificador de controle do Lote de envio do Lote
        # Exemplo de @lote:
        # @nf1_xml, @nf1_hash = @webservice.assinarNF(...)
        # @nf2_xml, @nf2_hash = @webservice.assinarNF(...)
        # @lote = [ @nf1_xml, @nf2_hash ]
        def enviarLoteNF(lote, indSinc, idLote)
          versao = "4.00"
          lote = (lote.map { |el| el.is_a?(Hash) ? el[:NFe] : el.to_hash![:NFe] })
          hash = {
            enviNFe: { :@xmlns => "http://www.portalfiscal.inf.br/nfe", :@versao => versao,
              idLote: idLote,
              indSinc: indSinc,
              NFe: lote
            }
          }
          wsdl = SEFAZ::Webservice::NFE::WSDL.get(:NFeAutorizacao, @ambiente, @uf)
          conn = SEFAZ::Webservice::NFE::Connection.new(@pkcs12Tss, wsdl, versao, @uf)
          resp = conn.call(:nfe_autorizacao_lote, hash)
          return [resp.body.to_xml!, resp.body]
        end
    
        # Calcular Chave NF
        # @uf = Código da UF do emitente do Documento Fiscal
        # @aamm = Ano e Mês de emissão da NF-e
        # @cnpj = CNPJ do emitente
        # @modelo = Modelo do Documento Fiscal (55 ou 65)
        # @serie = Série do Documento Fiscal
        # @nNF = Número do Documento Fiscal
        # @tpEmis = Forma de emissão da NF-e
        # @cNF = Código Numérico que compõe a Chave de Acesso (ID do sistema)
        def calculaChaveNF(uf, aamm, cnpj, modelo, serie, nNF, tpEmis, cNF)
          uf = uf.to_s.rjust(2, "0")
          aamm = aamm.to_s.rjust(4, "0")
          cnpj = cnpj.to_s.delete("^0-9").rjust(14, "0")
          modelo = modelo.to_s.rjust(2, "0")
          serie = serie.to_s.rjust(3, "0")
          nNF = nNF.to_s.rjust(9, "0")
          cNF = cNF.to_s.rjust(8, "0")
          nChave = "#{uf[0,2]}#{aamm[0,4]}#{cnpj[0,14]}#{modelo[0,2]}#{serie[0,3]}#{nNF[0,9]}#{tpEmis[0,1]}#{cNF[0,8]}"
          nPesos = "4329876543298765432987654329876543298765432"
          cDV = 11 - (nChave.split("").each_with_index.map { |n, index| n.to_i * nPesos[index].to_i }.sum % 11)
          return ["#{nChave}#{cDV}", cDV]
        end
    
        # Valida NF no SEFAZ RS NF-e (https://www.sefaz.rs.gov.br/NFE/NFE-VAL.aspx)
        # @documento(Hash ou String) = XML ou HASH que será validado
        # @openTimeout(Integer) = Tempo de espera em segundos para abrir conexão (opcional: padrão 60)
        # @readTimeout(Integer) = Tempo de espera em segundos para ler resposta (opcional: padrão 60)
        def validarNF(documento, openTimeout = 60, readTimeout = 60)
          xml = (documento.is_a?(Hash) ? documento.to_xml! : documento)
          validator = SEFAZ::Webservice::NFE::Validator.new(xml)
          stat, msg, err = validator.exec(openTimeout, readTimeout)
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
          xml = (documento.is_a?(Hash) ? documento.to_xml! : documento)
          auditor = SEFAZ::Webservice::NFE::Auditor.new(xml)
          stat, msg = auditor.exec(openTimeout, readTimeout)
          case stat
          when :ok; return [true, msg]
          else      return [false, {}]
          end
        end
    
        # Inutilizar NF - Gera, assina e envia o documento com certificado A1 (exportarInutilizarNF, assinarNF, enviarInutilizarNF)
        # OBS: Caso parâmetro @chaveInut estiver em branco, a chave será calculada automaticamente (calculaChaveInutilizacao)
        # @chaveInut = Identificador da TAG a ser assinada
        # @ano = Ano de inutilização da numeração
        # @modelo = Modelo do documento (55 ou 65)
        # @serie = Série da NF-e
        # @nroNFIni = Número da NF-e inicial a ser inutilizada
        # @nroNFFin = Número da NF-e final a ser inutilizada
        # @justificativa = Informar a justificativa do pedido de inutilização
        def inutilizarNF(chaveInut, ano, modelo, serie, nroNFIni, nroNFFin, justificativa)
          _, hash = exportarInutilizarNF(chaveInut, ano, modelo, serie, nroNFIni, nroNFFin, justificativa)
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
        #      Caso parâmetro @chaveInut estiver em branco, a chave será calculada automaticamente (calculaChaveInutilizacao)
        # @chaveInut = Identificador da TAG a ser assinada
        # @ano = Ano de inutilização da numeração
        # @modelo = Modelo do documento (55 ou 65)
        # @serie = Série da NF-e
        # @nroNFIni = Número da NF-e inicial a ser inutilizada
        # @nroNFFin = Número da NF-e final a ser inutilizada
        # @justificativa = Informar a justificativa do pedido de inutilização
        def exportarInutilizarNF(chaveInut, ano, modelo, serie, nroNFIni, nroNFFin, justificativa)
          versao  = "4.00"
          chaveInut = calculaChaveInutilizacao(ano, @cnpj, modelo, serie, nroNFIni, nroNFFin) if chaveInut.blank?
          hash = { inutNFe: { :@xmlns => "http://www.portalfiscal.inf.br/nfe", :@versao => versao, infInut: {
            :@Id => chaveInut,
            tpAmb:  @ambiente,
            xServ:  'INUTILIZAR',
            cUF:    @uf,
            ano:    ano,
            CNPJ:   @cnpj,
            mod:    modelo,
            serie:  serie,
            nNFIni: nroNFIni,
            nNFFin: nroNFFin,
            xJust:  justificativa
          } } }
          return [hash.to_xml!, hash]
        end
    
        # Enviar Inutilização NF - Necessário um documento assinado
        # OBS: Recomendado quando utilizado o certificado A3
        # @documento(Hash ou String) = XML ou HASH assinado que será enviado
        def enviarInutilizarNF(documento)
          versao = "4.00"
          hash = (documento.is_a?(Hash) ? documento : documento.to_hash!)
          wsdl = SEFAZ::Webservice::NFE::WSDL.get(:NfeInutilizacao, @ambiente, @uf)
          conn = SEFAZ::Webservice::NFE::Connection.new(@pkcs12Tss, wsdl, versao, @uf)
          resp = conn.call(:nfe_inutilizacao_nf, hash)
          return [resp.body.to_xml!, resp.body]
        end
    
        # Cancelar NF - Gera, assina e envia o documento com certificado A1 (exportarCancelarNF, assinarNF, enviarEvento)
        # @chaveNF = Chave de acesso de uma NF
        # @sequenciaEvento = O número do evento
        # @dataHoraEvento = Data e Hora da Emissão do Evento (ex: 2023-01-15T17:23:00+03:00)
        # @numProtocolo = Número do Protocolo de registro da NF
        # @justificativa = Motivo do cancelamento da NF
        # @idLote = Número de controle interno
        def cancelarNF(chaveNF, sequenciaEvento, dataHoraEvento, numProtocolo, justificativa, idLote)
          _, hash = exportarCancelarNF(chaveNF, sequenciaEvento, dataHoraEvento, numProtocolo, justificativa)
          _, hash = assinarNF(hash)
          return enviarEvento(hash, idLote)
        end
    
        # Exportar Cancelar NF - Exporta um documento bruto (sem assinatura)
        # OBS: Recomendado quando utilizado o certificado A3
        # @chaveNF = Chave de acesso de uma NF
        # @sequenciaEvento = O número do evento
        # @dataHoraEvento = Data e Hora da Emissão do Evento (ex: 2023-01-15T17:23:00+03:00)
        # @numProtocolo = Número do Protocolo de registro da NF
        # @justificativa = Motivo do cancelamento da NF
        # @idLote = Número de controle interno
        def exportarCancelarNF(chaveNF, sequenciaEvento, dataHoraEvento, numProtocolo, justificativa)
          versao = "1.00"
          tpEvento = "110111"
          _, hash  = gerarLeiauteEvento(versao, tpEvento, chaveNF, sequenciaEvento, dataHoraEvento)
          hash[:evento][:infEvento][:detEvento] = { :@versao => versao,
            descEvento: "Cancelamento",
            nProt: numProtocolo,
            xJust: justificativa
          }
          return [hash.to_xml!, hash]
        end
    
        # Enviar CCe - Gera, assina e envia o documento com certificado A1 (exportarCCe, assinarNF, enviarEvento)
        # @chaveNF = Chave de acesso de uma NF
        # @sequenciaEvento = O número do evento
        # @dataHoraEvento = Data e Hora da Emissão do Evento (ex: 2023-01-15T17:23:00+03:00)
        # @textoCorrecao = Motivo do cancelamento da NF
        # @idLote = Número de controle interno
        def enviarCCe(chaveNF, sequenciaEvento, dataHoraEvento, textoCorrecao, idLote)
          _, hash = exportarCCe(chaveNF, sequenciaEvento, dataHoraEvento, textoCorrecao)
          _, hash = assinarNF(hash)
          return enviarEvento(hash, idLote)
        end
    
        # Exportar CCe - Exporta um documento bruto (sem assinatura)
        # OBS: Recomendado quando utilizado o certificado A3
        # @chaveNF = Chave de acesso de uma NF
        # @sequenciaEvento = O número do evento
        # @dataHoraEvento = Data e Hora da Emissão do Evento (ex: 2023-01-15T17:23:00+03:00)
        # @textoCorrecao = Motivo do cancelamento da NF
        def exportarCCe(chaveNF, sequenciaEvento, dataHoraEvento, textoCorrecao)
          versao = "1.00"
          tpEvento = "110110"
          _, hash  = gerarLeiauteEvento(versao, tpEvento, chaveNF, sequenciaEvento, dataHoraEvento)
          hash[:evento][:infEvento][:detEvento] = { :@versao => versao,
            descEvento: "Carta de Correcao",
            xCorrecao: textoCorrecao,
            xCondUso: "A Carta de Correcao e disciplinada pelo paragrafo 1o-A do art. 7o do Convenio S/N, de 15 de dezembro de 1970 e pode ser utilizada para regularizacao de erro ocorrido na emissao de documento fiscal, desde que o erro nao esteja relacionado com: I - as variaveis que determinam o valor do imposto tais como: base de calculo, aliquota, diferenca de preco, quantidade, valor da operacao ou da prestacao; II - a correcao de dados cadastrais que implique mudanca do remetente ou do destinatario; III - a data de emissao ou de saida."
          }
          return [hash.to_xml!, hash]
        end
    
        # Enviar Evento - Necessário um documento assinado
        # OBS: Recomendado quando utilizado o certificado A3
        # @evento(Hash ou String) = XML ou HASH assinado que será enviado
        # @idLote(String) = Identificador de controle do Lote de envio do Evento
        def enviarEvento(evento, idLote)
          return enviarLoteDeEvento([ evento ], idLote)
        end
    
        # Envia Lote de Eventos - Necessário que cada evento esteja assinado
        # OBS: Recomendado quando utilizado o certificado A3 e/ou para envio em lote de eventos
        #      Cada elemento do Array pode ser Hash ou XML assinados
        # @lote(Array) = Array de eventos assinados
        # @idLote(String) = Identificador de controle do Lote de envio do Evento
        # Exemplo de @lote:
        # @eve1_xml, @eve1_hash = @webservice.exportarCancelarNF(...)
        # @eve2_xml, @eve2_hash = @webservice.exportarCancelarNF(...)
        # @lote = [ @eve1_xml, @eve2_hash ]
        def enviarLoteDeEvento(lote, idLote)
          versao = "1.00"
          lote = (lote.map { |el| el.is_a?(Hash) ? el[:evento] : el.to_hash![:evento] })
          hash = {
            envEvento: { :@xmlns => "http://www.portalfiscal.inf.br/nfe", :@versao => versao,
              idLote: idLote,
              evento: lote
            }
          }
          wsdl = SEFAZ::Webservice::NFE::WSDL.get(:RecepcaoEvento, @ambiente, @uf)
          conn = SEFAZ::Webservice::NFE::Connection.new(@pkcs12Tss, wsdl, versao, @uf)
          resp = conn.call(:nfe_recepcao_evento, hash)
          return [resp.body.to_xml!, resp.body]
        end
    
        # Gera Informações do Responsável Técnico - Calcula o hashCSRT e cria o grupo do responsável técnico
        # Necessário quando estiver emitindo uma NF-e/NFC-e
        # @documento(Hash ou String) = XML ou HASH que será tratado
        def gerarInfRespTec(documento)
          hash = (documento.is_a?(Hash) ? documento : documento.to_hash!)
          chaveNF = hash[:NFe][:infNFe][:@Id].to_s.delete("^0-9")
          concat = @CSRT.to_s + chaveNF.to_s
          hexdigest = Digest::SHA1.hexdigest(concat)
          hashCSRT  = Base64.strict_encode64(hexdigest)
          infRespTec = { infRespTec: { CNPJ: @cnpjTec, xContato: @contatoTec, email: @emailTec, fone: @foneTec, idCSRT: @idCSRT, hashCSRT: hashCSRT } }.compress!
          hash[:NFe][:infNFe][:infRespTec] = infRespTec[:infRespTec]
          return [hash.to_xml!, hash]
        end
    
        private
    
          # Gera o Leiaute Mensagem de Entrada (Parte Geral) dos Eventos
          # Utilizado internamente nos métodos: exportarCancelarNF, exportarCCe, exportarManifestacao, ... (métodos de eventos)
          def gerarLeiauteEvento(verEvento, tpEvento, chaveNF, sequenciaEvento, dataHoraEvento)
            versao = "1.00"
            id = "ID" + tpEvento.to_s + chaveNF.to_s + sequenciaEvento.to_s.rjust(2, "0")
            hash = {
              evento: { :@xmlns => "http://www.portalfiscal.inf.br/nfe", :@versao => versao,
                infEvento: { :@Id => id,
                  cOrgao: @uf,
                  tpAmb: @ambiente,
                  CNPJ: @cnpj,
                  chNFe: chaveNF,
                  dhEvento: dataHoraEvento,
                  tpEvento: tpEvento,
                  nSeqEvento: sequenciaEvento,
                  verEvento: verEvento
                }
              }
            }
            return [hash.to_xml!, hash]
          end
    
      end      
    end
  end
end
