---
applyTo: "lib/sefaz/**/*.rb"
---

# Instruções para a camada de webservices e utilitários da gem

## Objetivo

Manter o padrão atual das integrações SOAP e document generation da gem `sefaz`, preservando a estrutura de módulos e a convenção de retorno adotada pela biblioteca.

## Padrões

- O código é organizado em módulos e classes dentro de `SEFAZ`, `SEFAZ::Webservice`, `SEFAZ::Utils` e `SEFAZ::Webservice::NFE`/`SAT`.
- A camada pública é composta principalmente por `Client` com métodos específicos do domínio (`statusDoServico`, `enviarNF`, `cancelarNF`, `exportarCF`, etc.).
- A conversão XML ↔ Hash é feita com os refinamentos definidos em `lib/sefaz/refinement.rb`:
  - `String#to_hash!`
  - `Hash#to_xml!`
  - `Hash#compress!` / `String#compress!`
- Os clientes fazem calls SOAP via `Savon` e a classe de conexão base em `lib/sefaz/utils/connection.rb`.
- As respostas e retornos seguem o padrão já usado no projeto: o método geralmente retorna uma estrutura em array, como `[xml, hash]` ou `[true, msg, err]`.

## Convenções

- Preserve a nomenclatura da biblioteca em português e alinhada ao domínio fiscal:
  - `setaAmbiente`, `setaRespTecnico`, `setaPFXTss`, `setaPFXAss`
  - `statusDoServico`, `consultarNF`, `inutilizarNF`, `exportarCCe`, `gerarDANFE`
  - `calculaChaveNF`, `calculaChaveInutilizacao`
- Use `@uf`, `@ambiente`, `@cnpj`, `@pkcs12Tss` e `@pkcs12Ass` como estado do cliente quando o comportamento depender desses dados.
- Mantenha `# frozen_string_literal: true` e módulos aninhados da mesma forma já adotada.
- Quando o método manipula XML ou Hash, deixe o transform para `to_xml!`/`to_hash!` em vez de criar serializers alternativos.

## Regras

- Não crie uma arquitetura nova de serviços, controllers, jobs ou banco para essa gem.
- Quando for adicionar um novo método em `SEFAZ::Webservice::NFE::Client`, siga o estilo do módulo existente: método público de domínio, uso de hash/XML e retorno consistente com o restante da classe.
- Ao implementar um fluxo envolvendo assinatura, preserve a diferenciação entre certificado de transmissão e assinatura.
- Para documentos NF-e, siga o padrão de composição usado em `SEFAZ::Webservice::NFE::Dataset` e em `lib/sefaz/webservice/nfe/templates/*`.
- Para SAT, mantenha o padrão de `SEFAZ::Webservice::SAT::Client#exportarCF` e `Templates::*` para PDF/CF-e.
- Reaproveite `SEFAZ::Configuration.default` quando existir configuração global relevante.

## Restrições

- Não transformar a gem em um projeto Rails.
- Não introduzir `ActiveRecord`, migrations, banco, ou gerenciamento de usuários.
- Não substituir `Savon` por outra biblioteca HTTP sem necessidade real.
- Não interromper o padrão de retorno `[xml, hash]` em métodos que já têm esse padrão.
- Não adicionar logs de certificado, senha, chave privada ou dados fiscais sensíveis.

## Testes

- Os testes relevantes ficam em `test/sefaz/webservice/...` e `test/sefaz/utils/...`.
- Use fixtures localizados em `test/fixtures/NFe` e `test/fixtures/CFe`.
- As expectativas devem verificar valores reais do projeto, como `cStat`, `hash[:NFe]`, `hash[:evento]` e outros campos estruturados esperados.
- Ao adicionar ou alterar comportamento, prefira validar o teste do módulo diretamente (`test/sefaz/webservice/nfe/test_client.rb` ou o arquivo mais específico do comportamento).

## Exceções

- O módulo NFE contém muitos métodos de evento e XML; alguns deles são específicos e não devem ser generalizados para um padrão de serviço genérico.
- O módulo SAT tem um foco diferente (PDF/CF-e) e deve continuar seguindo a API de `exportarCF` e templates próprios.
- Não confundir o padrão atual da gem com um padrão genérico de Ruby/enterprise; a regra do projeto é preservar a biblioteca existente e não inventar uma arquitetura nova.
