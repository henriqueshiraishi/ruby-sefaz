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
    ambiente: "1",  # 1=Produção; 2=Homologação
    uf: "35"        # Código IBGE do Estado
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
*Observação: Caso é utilizado certificado A3 para assinatura de XML, não é necessário executar essa configuração. A biblioteca disponibiliza métodos que permite exportar o XML em HASH para realizar tratamento externo, como por exemplo, assinatura local de XML.*

## Utilização

Após a configuração, é possível acessar os seguintes serviços:
```ruby
# Consulta Status SEFAZ
@webService.statusDoServico
# => XML no formato de HASH

# Consulta Situação NF
# @chaveNF(String) = Chave de acesso de uma NF
@webService.consultarNF(@chaveNF)
# => XML no formato de HASH

# Consulta Cadastro
# @nroDocumento(String) = Número do documento
# @tpDocumento(String)  = CNPJ/CPF/IE
# @uf(String) = Sigla do estado que será consultado (SP; MG; RJ; ...)
@webService.consultarCadastro(@nroDocumento, @tpDocumento, @uf)
# => XML no formato de HASH
```

## Desenvolvimento

Depois de verificar o repositório, execute `bin/setup` para instalar as dependências. Em seguida, execute `rake test` para executar os testes. Você também pode executar `bin/console` para um prompt interativo que permitirá que você experimente.

Para instalar esta gem em sua máquina local, execute `bundle exec rake install`. Para lançar uma nova versão, atualize o número da versão em `version.rb`, e então execute `bundle exec rake release`, que criará uma tag git para a versão, push git commits e a tag criada, e envia o pacote `.gem` para o [rubygems.org](https://rubygems.org).

## Contribuição

Relatórios de bugs e solicitações pull são bem-vindos no GitHub em https://github.com/henriqueshiraishi/ruby-sefaz.

## Licença

A gema está disponível como código aberto sob os termos da [MIT License](https://opensource.org/licenses/MIT).
