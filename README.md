# Biblioteca SEFAZ

[![Gem Version](https://badge.fury.io/rb/sefaz.svg)](https://badge.fury.io/rb/sefaz)

## Instalação

Biblioteca SEFAZ está disponível no RubyGems e pode ser instalada via:

```bash
gem install sefaz
```

ou adiciona no arquivo Gemfile e execute o `bundle install`:

```ruby
gem 'sefaz'
```

## Configuração

Crie uma instância da classe `SEFAZ::NFE` para acessar os serviços disponíveis na biblioteca:

```ruby
@webService = SEFAZ::NFE.new
```

Após instanciar, é necessário parametrizar a biblioteca:

- Configuração do Ambiente

```ruby
@webService.setaAmbiente({
    ambiente: "2",              # 1=Produção; 2=Homologação
    uf: "35"                    # Código IBGE do Estado
    cnpj: "00.000.000/0000-00"  # CNPJ da empresa emissora
})
```

- Configuração do Responsável Técnico

```ruby
@webService.setaRespTecnico({
    cnpj: "00.000.000/0000-00",
    contato: "EMPRESA",
    email: "contato@empresa.com.br",
    fone: "+551100000000",
    idCSRT: "01",
    CSRT: "G8063VRTNDMO886SFNK5LDUDEI24XJ22YIPO" 
})
```

- Configuração do PFX de transmissão

```ruby
@webService = setaPFXTss({
    pfx: File.read("certificado_tss.pfx"),
    senha: "senha_super_secreta"
})
```

*Observação: A biblioteca não permite o certificado A3 para transmissão SOAP. Lembrando que, o certificado de transmissão pode ser diferente do certificado de assinatura de XML.*

- Configuração do PFX de assinatura

```ruby
@webService.setaPFXAss({
    pfx: File.read("certificado_ass.pfx"),
    senha: "senha_super_secreta"
})
```

*Observação: Caso é utilizado certificado A3 para assinatura de XML, não é necessário executar essa configuração. A biblioteca disponibiliza métodos que permite exportar o XML e HASH para realizar tratamento externo, como por exemplo, assinatura local de XML com certificado A3.*

## Utilização

Após a configuração, é possível acessar os seguintes serviços:

```ruby
# Consulta Status SEFAZ
xml, hash = @webService.statusDoServico

# Consulta Situação NF
# @chaveNF(String) = Chave de acesso de uma NF
xml, hash = @webService.consultarNF(@chaveNF)

# Consulta Cadastro
# @nroDocumento(String) = Número do documento
# @tpDocumento(String)  = CNPJ/CPF/IE
# @uf(String) = Sigla do estado que será consultado (SP; MG; RJ; ...)
xml, hash = @webService.consultarCadastro(@nroDocumento, @tpDocumento, @uf)

# Consulta Recebido de Lote
# @numRecibo(String) = Número do recibo do lote de NF-e
xml, hash = @webService.consultarRecibo(@numRecibo)

# Assinar NF - PFX de assinatura - Certificado A1
# @documento(Hash ou String) = XML ou HASH que será assinado
xml, hash = @webService.assinarNF(@documento)

# Enviar NF - Necessário uma NF assinada
# @documento(Hash ou String) = XML ou HASH assinado que será enviado
# @indSinc(String) = "0"=Assíncrono / "1"=Síncrono
# @idLote(String) = Identificador de controle do Lote de envio do Lote
xml, hash = @webService.enviarNF(@documento, @indSinc, @idLote)

# Envia Lote de NF - Necessário que cada NF esteja assinada
# OBS: Recomendado para envio em lote de NF, cada elemento do Array pode ser Hash ou XML assinados
# @lote(Array) = Array de NF assinadas
# @indSinc(String) = "0"=Assíncrono / "1"=Síncrono
# @idLote(String) = Identificador de controle do Lote de envio do Lote
# Exemplo de @lote:
# @nf1_xml, @nf1_hash = @webService.assinarNF(...)
# @nf2_xml, @nf2_hash = @webService.assinarNF(...)
# @lote = [ @nf1_xml, @nf2_hash ]
xml, hash = @webService.enviarLoteNF(@lote, @indSinc, @idLote)

# Calcular Chave NF
# @uf = Código da UF do emitente do Documento Fiscal
# @aamm = Ano e Mês de emissão da NF-e
# @cnpj = CNPJ do emitente
# @modelo = Modelo do Documento Fiscal (55 ou 65)
# @serie = Série do Documento Fiscal
# @nNF = Número do Documento Fiscal
# @tpEmis = Forma de emissão da NF-e
# @cNF = Código Numérico que compõe a Chave de Acesso (ID do sistema)
chaveNF, cDV = @webService.calculaChaveNF(@uf, @aamm, @cnpj, @modelo, @serie, @nNF, @tpEmis, @cNF)

# Valida NF no SEFAZ RS NF-e (https://www.sefaz.rs.gov.br/NFE/NFE-VAL.aspx)
# @documento(Hash ou String) = XML ou HASH que será validado
# @openTimeout(Integer) = Tempo de espera em segundos para abrir conexão (opcional: padrão 60)
# @readTimeout(Integer) = Tempo de espera em segundos para ler resposta (opcional: padrão 60)
# => @stat = True/False se a validação foi executada com sucesso
# => @msg  = Hash com todas as mensagens geradas pelo validador
# => @err  = Hash com todas as mensagens de erros geradas pelo validador
stat, msg, err = @webService.validarNF(@documento)

# Auditar NF no validador TecnoSpeed (https://validador.nfe.tecnospeed.com.br/)
# @documento(Hash ou String) = XML ou HASH que será auditado
# @openTimeout(Integer) = Tempo de espera em segundos para abrir conexão (opcional: padrão 60)
# @readTimeout(Integer) = Tempo de espera em segundos para ler resposta (opcional: padrão 60)
# => @stat = True/False se o auditor foi executado com sucesso
# => @msg  = Hash com todas as mensagens geradas pelo auditor
stat, msg = @webService.auditarNF(@documento)

# Gerar DANFE pelo FreeNFe (https://www.freenfe.com.br/leitor-de-xml-online)
# @documento(Hash ou String) = XML ou HASH que será gerado
# @openTimeout(Integer) = Tempo de espera em segundos para abrir conexão (opcional: padrão 60)
# @readTimeout(Integer) = Tempo de espera em segundos para ler resposta (opcional: padrão 60)
# => @stat = True/False se o gerador de DANFE foi executado com sucesso
# => @pdf  = String com binário do arquivo PDF gerado
stat, pdf = @webService.gerarDANFE(@documento)

# Inutilizar NF - Gera, assina e envia o documento com certificado A1 (exportarInutilizarNF, assinarNF, enviarInutilizarNF)
# OBS: Caso parâmetro @chaveInut estiver em branco, a chave será calculada automaticamente (calculaChaveInutilizacao)
# @chaveInut = Identificador da TAG a ser assinada
# @ano = Ano de inutilização da numeração
# @modelo = Modelo do documento (55 ou 65)
# @serie = Série da NF-e
# @nroNFIni = Número da NF-e inicial a ser inutilizada
# @nroNFFin = Número da NF-e final a ser inutilizada
# @justificativa = Informar a justificativa do pedido de inutilização
xml, hash = @webService.inutilizarNF(@chaveInut, @ano, @modelo, @serie, @nroNFIni, @nroNFFin, @justificativa)

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
xml, hash = @webService.exportarInutilizarNF(@chaveInut, @ano, @modelo, @serie, @nroNFIni, @nroNFFin, @justificativa)

# Enviar Inutilização NF - Necessário um documento assinado
# OBS: Recomendado quando utilizado o certificado A3
# @documento(Hash ou String) = XML ou HASH assinado que será enviado
xml, hash = @webService.enviarInutilizarNF(@documento)

# Calcular Chave de Inutilização
# @ano = Ano de inutilização da numeração
# @cnpj = CNPJ do emitente
# @modelo = Modelo do documento (55 ou 65)
# @serie = Série da NF-e
# @nroNFIni = Número da NF-e inicial a ser inutilizada
# @nroNFFin = Número da NF-e final a ser inutilizada
chaveInut = @webService.calculaChaveInutilizacao(@ano, @cnpj, @modelo, @serie, @nroNFIni, @nroNFFin)

# Cancelar NF - Gera, assina e envia o documento com certificado A1 (exportarCancelarNF, assinarNF, enviarEvento)
# @chaveNF = Chave de acesso de uma NF
# @sequenciaEvento = O número do evento
# @dataHoraEvento = Data e Hora da Emissão do Evento (ex: 2023-01-15T17:23:00+03:00)
# @numProtocolo = Número do Protocolo de registro da NF
# @justificativa = Motivo do cancelamento da NF
# @idLote = Número de controle interno
xml, hash = @webService.cancelarNF(@chaveNF, @sequenciaEvento, @dataHoraEvento, @numProtocolo, @justificativa, @idLote)

# Exportar Cancelar NF - Exporta um documento bruto (sem assinatura)
# OBS: Recomendado quando utilizado o certificado A3
# @chaveNF = Chave de acesso de uma NF
# @sequenciaEvento = O número do evento
# @dataHoraEvento = Data e Hora da Emissão do Evento (ex: 2023-01-15T17:23:00+03:00)
# @numProtocolo = Número do Protocolo de registro da NF
# @justificativa = Motivo do cancelamento da NF
# @idLote = Número de controle interno
xml, hash = @webService.exportarCancelarNF(@chaveNF, @sequenciaEvento, @dataHoraEvento, @numProtocolo, @justificativa)

# Enviar Evento - Necessário um documento assinado
# OBS: Recomendado quando utilizado o certificado A3
# @evento(Hash ou String) = XML ou HASH assinado que será enviado
# @idLote(String) = Identificador de controle do Lote de envio do Evento
xml, hash = @webService.enviarEvento(@evento, @idLote)

# Envia Lote de Eventos - Necessário que cada evento esteja assinado
# OBS: Recomendado quando utilizado o certificado A3 e/ou para envio em lote de eventos
#      Cada elemento do Array pode ser Hash ou XML assinados
# @lote(Array) = Array de eventos assinados
# @idLote(String) = Identificador de controle do Lote de envio do Evento
# Exemplo de @lote:
# @eve1_xml, @eve1_hash = @webService.exportarCancelarNF(...)
# @eve2_xml, @eve2_hash = @webService.exportarCancelarNF(...)
# @lote = [ @eve1_xml, @eve2_hash ]
xml, hash = @webService.enviarLoteDeEvento(@lote, @idLote)

# Enviar CCe - Gera, assina e envia o documento com certificado A1 (exportarCCe, assinarNF, enviarEvento)
# @chaveNF = Chave de acesso de uma NF
# @sequenciaEvento = O número do evento
# @dataHoraEvento = Data e Hora da Emissão do Evento (ex: 2023-01-15T17:23:00+03:00)
# @textoCorrecao = Motivo do cancelamento da NF
# @idLote = Número de controle interno
xml, hash = @webService.enviarCCe(@chaveNF, @sequenciaEvento, @dataHoraEvento, @textoCorrecao, @idLote)

# Exportar CCe - Exporta um documento bruto (sem assinatura)
# OBS: Recomendado quando utilizado o certificado A3
# @chaveNF = Chave de acesso de uma NF
# @sequenciaEvento = O número do evento
# @dataHoraEvento = Data e Hora da Emissão do Evento (ex: 2023-01-15T17:23:00+03:00)
# @textoCorrecao = Motivo do cancelamento da NF
xml, hash = @webService.exportarCCe(@chaveNF, @sequenciaEvento, @dataHoraEvento, @textoCorrecao)

# Gera Informações do Responsável Técnico - Calcula o hashCSRT e cria o grupo do responsável técnico
# Necessário quando estiver emitindo uma NF-e/NFC-e
# @documento(Hash ou String) = XML ou HASH que será tratado
xml, hash = @webService.gerarInfRespTec(@documento)
```

## Enviando NF com DataSet

Acessa o arquivo [lib/sefaz/dataset/nfe.md](https://github.com/henriqueshiraishi/ruby-sefaz/blob/main/lib/sefaz/dataset/nfe.md) para visualizar todos os campos que pode ser informado no DataSet.

```ruby
# Declarando os campos necessários para calcular a chave da NF
@uf = "35"
@aamm = "2303"
@cnpj = "21684155000164"
@modelo = "55"
@serie = "1"
@nNF = "244"
@tpEmis = "1"
@cNF = "07522998"

# Calculando a chave e o dígito verificador da NF
@chaveNF, @cDV = @webService.calculaChaveNF(@uf, @aamm, @cnpj, @modelo, @serie, @nNF, @tpEmis, @cNF)

# Instanciando objeto DataSet
@dataSet = SEFAZ::DataSet::NFE.new(@chaveNF)

# Inserindo os dados da NF
@dataSet.ide.cUF = @uf
@dataSet.ide.cNF = @cNF
@dataSet.ide.natOp = "Venda de Mercadoria"
@dataSet.ide.mod = @modelo
@dataSet.ide.serie = @serie
@dataSet.ide.nNF = @nNF
@dataSet.ide.dhEmi = "2023-03-21T17:10:03+00:00"
@dataSet.ide.dhSaiEnt = "2023-03-21T17:10:03+00:00"
@dataSet.ide.tpNF = "1"
@dataSet.ide.idDest = "1"
@dataSet.ide.cMunFG = "3550308"
@dataSet.ide.tpImp = "1"
@dataSet.ide.tpEmis = @tpEmis
@dataSet.ide.cDV = @cDV
@dataSet.ide.tpAmb = "2"
@dataSet.ide.finNFe = "1"
@dataSet.ide.indFinal = "0"
@dataSet.ide.indPres = "0"
@dataSet.ide.procEmi = "0"
@dataSet.ide.verProc = "4.0.1"

@dataSet.emit.CNPJ = @cnpj
@dataSet.emit.xNome = "PHS INDUSTRIA METALURGICA EIRELI"
@dataSet.emit.xFant = "PHS"
@dataSet.emit.enderEmit.xLgr = "RUA SANTO HENRIQUE"
@dataSet.emit.enderEmit.nro = "926"
@dataSet.emit.enderEmit.xBairro = "VILA RE"
@dataSet.emit.enderEmit.cMun = "3550308"
@dataSet.emit.enderEmit.xMun = "SAO PAULO"
@dataSet.emit.enderEmit.UF = "SP"
@dataSet.emit.enderEmit.CEP = "03664010"
@dataSet.emit.enderEmit.cPais = "1058"
@dataSet.emit.enderEmit.xPais = "Brasil"
@dataSet.emit.enderEmit.fone = "1134676938"
@dataSet.emit.IE = "144190701117"
@dataSet.emit.IM = "51610965"
@dataSet.emit.CNAE = "2599399"
@dataSet.emit.CRT = "1"

@dataSet.dest.CNPJ = "01947271000111"
@dataSet.dest.xNome = "NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL"
@dataSet.dest.enderDest.xLgr = "RUA SALGADO DE CASTRO"
@dataSet.dest.enderDest.nro = "265"
@dataSet.dest.enderDest.xBairro = "VILA MARINA"
@dataSet.dest.enderDest.cMun = "3513801"
@dataSet.dest.enderDest.xMun = "DIADEMA"
@dataSet.dest.enderDest.UF = "SP"
@dataSet.dest.enderDest.CEP = "09920690"
@dataSet.dest.enderDest.cPais = "1058"
@dataSet.dest.enderDest.xPais = "BRASIL"
@dataSet.dest.enderDest.fone = "1140555455"
@dataSet.dest.indIEDest = "1"
@dataSet.dest.IE = "286145468117"

@dataSet.incluirParte("DET")

@dataSet.det.prod.cProd = "5.35.0160"
@dataSet.det.prod.cEAN = "SEM GTIN"
@dataSet.det.prod.xProd = "T-176, LATAO D5X4,,5MM, FURO 1.2MM"
@dataSet.det.prod.NCM = "74153300"
@dataSet.det.prod.CEST = "1006600"
@dataSet.det.prod.CFOP = "5101"
@dataSet.det.prod.uCom = "PC"
@dataSet.det.prod.qCom = "1000.0"
@dataSet.det.prod.vUnCom = "0.3800"
@dataSet.det.prod.vProd = "380.00"
@dataSet.det.prod.cEANTrib = "SEM GTIN"
@dataSet.det.prod.uTrib = "PC"
@dataSet.det.prod.qTrib = "1000.0"
@dataSet.det.prod.vUnTrib = "0.3800"
@dataSet.det.prod.indTot = "1"
@dataSet.det.prod.xPed = "OC 0123-000033"

@dataSet.det.imposto.vTotTrib = "0.00"

@dataSet.det.imposto.ICMS.ICMSSN101.orig = "0"
@dataSet.det.imposto.ICMS.ICMSSN101.CSOSN = "101"
@dataSet.det.imposto.ICMS.ICMSSN101.pCredSN = "1.86"
@dataSet.det.imposto.ICMS.ICMSSN101.vCredICMSSN = "7.07"

@dataSet.det.imposto.PIS.PISNT.CST = "07"
@dataSet.det.imposto.COFINS.COFINSNT.CST = "07"

@dataSet.salvarParte("DET")

@dataSet.total.ICMSTot.vBC = "0.00"
@dataSet.total.ICMSTot.vICMS = "0.00"
@dataSet.total.ICMSTot.vICMSDeson = "0.00"
@dataSet.total.ICMSTot.vFCPUFDest = "0.00"
@dataSet.total.ICMSTot.vICMSUFDest = "0.00"
@dataSet.total.ICMSTot.vICMSUFRemet = "0.00"
@dataSet.total.ICMSTot.vFCP = "0.00"
@dataSet.total.ICMSTot.vBCST = "0.00"
@dataSet.total.ICMSTot.vST = "0.00"
@dataSet.total.ICMSTot.vFCPST = "0.00"
@dataSet.total.ICMSTot.vFCPSTRet = "0.00"
@dataSet.total.ICMSTot.vProd = "380.00"
@dataSet.total.ICMSTot.vFrete = "0.00"
@dataSet.total.ICMSTot.vSeg = "0.00"
@dataSet.total.ICMSTot.vDesc = "0.00"
@dataSet.total.ICMSTot.vII = "0.00"
@dataSet.total.ICMSTot.vIPI = "0.00"
@dataSet.total.ICMSTot.vIPIDevol = "0.00"
@dataSet.total.ICMSTot.vPIS = "0.00"
@dataSet.total.ICMSTot.vCOFINS = "0.00"
@dataSet.total.ICMSTot.vOutro = "0.00"
@dataSet.total.ICMSTot.vNF = "380.00"
@dataSet.total.ICMSTot.vTotTrib = "0.00"

@dataSet.transp.modFrete = "0"

@dataSet.incluirParte("VOL")
@dataSet.vol.qVol = "1"
@dataSet.vol.esp = "VOLUME"
@dataSet.vol.pesoL = "1.000"
@dataSet.vol.pesoB = "1.000"
@dataSet.salvarParte("VOL")

@dataSet.cobr.fat.nFat = "86"
@dataSet.cobr.fat.vOrig = "380.00"
@dataSet.cobr.fat.vDesc = "0.00"
@dataSet.cobr.fat.vLiq = "380.00"

@dataSet.incluirParte("DUP")
@dataSet.dup.nDup = "001"
@dataSet.dup.dVenc = "2023-03-31"
@dataSet.dup.vDup = "380.00"
@dataSet.salvarParte("DUP")

@dataSet.incluirParte("DETPAG")
@dataSet.detPag.tPag = "15"
@dataSet.detPag.vPag = "380.00"
@dataSet.salvarParte("DETPAG")

@dataSet.infAdic.infCpl = "PEDIDO DO CLIENTE N OC 0123-000033. DOCUMENTO EMITIDO POR ME OU EPP OPTANTE PELO SIMPLES NACIONAL: PERMITE O APROVEITAMENTO DO CREDITO DE ICMS NO VALOR DE R 7,07; CORRESPONDENTE A ALIQUOTA DE 1.86, NOS TERMOS DO ART. 23 DA LEI COMPLEMENTAR N 123, DE 2006"

# Gerando e assinando XML
@xml, _ = @dataSet.gerarNF
@xml, _ = @webService.assinarNF(@xml)

# Enviando NF
@retEnviNFe = @webService.enviarNF(@xml, "0", "1")
```

## Consulta de recibo da NF

```ruby
# A partir do @retEnviNFe do exemplo anterior
@nRec = @retEnviNFe[1][:nfeResultMsg][:retEnviNFe][:infRec][:nRec]
@retConsReciNFe = @webService.consultarRecibo(@nRec)

@cStat = @retConsReciNFe[1][:nfeResultMsg][:retConsReciNFe][:protNFe][:infProt][:cStat]
@nProt = @retConsReciNFe[1][:nfeResultMsg][:retConsReciNFe][:protNFe][:infProt][:nProt]
```

## Cancelamento da NF

```ruby
# A partir da @chaveNF e @nProt dos exemplos anteriores
@sequenciaEvento = "1"
@dataHoraEvento = "2023-03-22T17:00:00+03:00"
@justificativa = "NF-e emitida em duplicidade."
@idLote = "1"
@retEnvEvento = @webService.cancelarNF(@chaveNF, @sequenciaEvento, @dataHoraEvento, @nProt, @justificativa, @idLote)

@cStat = @retEnvEvento[1][:nfeResultMsg][:retEnvEvento][:retEvento][:infEvento][:cStat]
@xMotivo = @retEnvEvento[1][:nfeResultMsg][:retEnvEvento][:retEvento][:infEvento][:xMotivo]
```

## Desenvolvimento

Depois de verificar o repositório, execute `bin/setup` para instalar as dependências. Em seguida, execute `rake test` para executar os testes. Você também pode executar `bin/console` para um prompt interativo que permitirá que você experimente.

Para instalar esta gem em sua máquina local, execute `bundle exec rake install`. Para lançar uma nova versão, atualize o número da versão em `version.rb`, e então execute `bundle exec rake release`, que criará uma tag git para a versão, push git commits e a tag criada, e envia o pacote `.gem` para o [rubygems.org](https://rubygems.org).

## Contribuição

Relatórios de bugs e solicitações pull são bem-vindos no GitHub em <https://github.com/henriqueshiraishi/ruby-sefaz>.

## Licença

A gema está disponível como código aberto sob os termos da [MIT License](https://opensource.org/licenses/MIT).
