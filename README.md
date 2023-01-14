# Biblioteca SEFAZ

[![Gem Version](https://badge.fury.io/rb/sefaz.svg)](https://badge.fury.io/rb/sefaz)

## Instalação

Biblioteca SEFAZ está disponível no RubyGems e pode ser instalada via:

```
$ gem install sefaz
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
    ambiente: "2",  # 1=Produção; 2=Homologação
    uf: "35"        # Código IBGE do Estado
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
# Gera Informações do Responsável Técnico - Calcula o hashCSRT e cria o grupo do responsável técnico
# Necessário quando estiver emitindo uma NF-e/NFC-e - Acionado automáticamente na emissão da NF
# @chaveNF(String) = Chave de acesso de uma NF
xml, hash = @webService.gerarInfRespTec(@chaveNF)

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

# Inutilizar NF - Gera, assina e envia o documento com certificado A1 (exportarDadosInutilizarNF, assinarNF, enviarDadosInutilizarNF)
# OBS: Caso parâmetro @chaveNF estiver em branco, a chave será calculada automaticamente (calculaChaveInutilizacao)
# @chaveNF = Identificador da TAG a ser assinada
# @ano = Ano de inutilização da numeração
# @cnpj = CNPJ do emitente
# @modelo = Modelo do documento (55 ou 65)
# @serie = Série da NF-e
# @nroNFIni = Número da NF-e inicial a ser inutilizada
# @nroNFFin = Número da NF-e final a ser inutilizada
# @justificativa = Informar a justificativa do pedido de inutilização
xml, hash = @webService.inutilizarNF(@chaveNF, @ano, @cnpj, @modelo, @serie, @nroNFIni, @nroNFFin, @justificativa)

# Calcular Chave de Inutilização
# @ano = Ano de inutilização da numeração
# @cnpj = CNPJ do emitente
# @modelo = Modelo do documento (55 ou 65)
# @serie = Série da NF-e
# @nroNFIni = Número da NF-e inicial a ser inutilizada
# @nroNFFin = Número da NF-e final a ser inutilizada
chaveNF = @webService.calculaChaveInutilizacao(@ano, @cnpj, @modelo, @serie, @nroNFIni, @nroNFFin)

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
xml, hash = @webService.exportarDadosInutilizarNF(@chaveNF, @ano, @cnpj, @modelo, @serie, @nroNFIni, @nroNFFin, @justificativa)

# Enviar Inutilização NF - Necessário um documento assinado
# OBS: Recomendado quando utilizado o certificado A3
# @documento(Hash ou String) = XML ou HASH assinado que será enviado
xml, hash = @webService.enviarDadosInutilizarNF(@documento)
```

## Desenvolvimento

Depois de verificar o repositório, execute `bin/setup` para instalar as dependências. Em seguida, execute `rake test` para executar os testes. Você também pode executar `bin/console` para um prompt interativo que permitirá que você experimente.

Para instalar esta gem em sua máquina local, execute `bundle exec rake install`. Para lançar uma nova versão, atualize o número da versão em `version.rb`, e então execute `bundle exec rake release`, que criará uma tag git para a versão, push git commits e a tag criada, e envia o pacote `.gem` para o [rubygems.org](https://rubygems.org).

## Contribuição

Relatórios de bugs e solicitações pull são bem-vindos no GitHub em https://github.com/henriqueshiraishi/ruby-sefaz.

## Licença

A gema está disponível como código aberto sob os termos da [MIT License](https://opensource.org/licenses/MIT).
