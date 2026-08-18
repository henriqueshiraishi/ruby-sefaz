# Instruções globais do projeto

## Identidade e stack

- Este repositório é uma gem Ruby, não uma aplicação Rails, não um backend web e não um projeto com banco de dados.
- O objetivo principal é integrar serviços tributários e gerar documentos XML/PDF para NF-e/NFC-e e CFe-SAT.
- Stack real identificada no código e configuração:
  - Ruby >= 2.7.8 (conforme `sefaz.gemspec`)
  - `savon` para SOAP
  - `prawn` e `br_danfe` para geração de documentos e DANFE
  - `barby` e `rqrcode` para códigos de barras/QR Code
  - `minitest` para testes
- Arquivos centrais: `lib/sefaz.rb`, `lib/sefaz/configuration.rb`, `lib/sefaz/refinement.rb`, `lib/sefaz/webservice/nfe/client.rb`, `lib/sefaz/webservice/sat/client.rb` e `test/test_helper.rb`.

## Estrutura do repositório

- `lib/`: código da gem.
- `lib/sefaz/`: classes base, refinamentos, configuração e integrações.
- `lib/sefaz/webservice/nfe/`: NF-e/NFC-e, WSDL, conexões, dataset, validadores, templates e eventos.
- `lib/sefaz/webservice/sat/`: geração de Cupom Fiscal Eletrônico SAT.
- `lib/sefaz/utils/`: utilitários compartilhados como conexão SOAP, assinatura e helpers de PDF.
- `test/`: suíte em Minitest;
- `test/fixtures/`: XML e PDFs utilizados nos testes;
- `docs/`: material oficial e referências de especificação.
- `certs/`: certificados locais usados em integração real.

## Arquitetura

- A arquitetura é orientada a biblioteca e exposição de APIs por classes de cliente.
- Os pontos de entrada principais são:
  - `SEFAZ::Webservice::NFE::Client`
  - `SEFAZ::Webservice::SAT::Client`
- O padrão predominante é: configurar o cliente com `setaAmbiente`, `setaRespTecnico`, `setaPFXTss` e `setaPFXAss`, depois chamar métodos de consulta, assinatura, validação ou envio.
- Os métodos de integração de NFE/SAT geralmente recebem XML ou Hash, transformam automaticamente quando necessário e retornam um conjunto de valores em formato consistente com o projeto:
  - `[xml, hash]` para operações de XML/hash
  - `[true, msg, err]` ou `[false, {}, {}]` para validação
  - `Hash#to_xml!` e `String#to_hash!` são o mecanismo padrão de conversão em toda a gem
- `SEFAZ::Utils::Connection` e `SEFAZ::Webservice::NFE::Connection` encapsulam a criação do cliente SOAP com `Savon`.
- O objeto `SEFAZ::Webservice::NFE::Dataset` é usado para montar documentos de NF-e por composição de `Struct`s e geração final de XML.

## Convenções globais

- Prefira manter a estrutura já existente em módulos aninhados: `SEFAZ`, `SEFAZ::Webservice`, `SEFAZ::Webservice::NFE`, `SEFAZ::Utils`.
- Use nomes de métodos em português e em estilo de domínio, como `statusDoServico`, `assinarNF`, `exportarCancelarNF`, `calculaChaveNF`, `gerarDANFE`.
- A biblioteca usa `@instance_var` para estado de sessão e configuração, especialmente `@uf`, `@ambiente`, `@cnpj`, `@pkcs12Tss` e `@pkcs12Ass`.
- Mantenha `# frozen_string_literal: true` em novos arquivos Ruby.
- Não introduza abstrações de framework, ORM, banco ou frontend que não existam no projeto.
- Quando criar ou alterar métodos de integração, preserve a API pública já adotada pelo projeto e não substitua o padrão de retorno existente.
- Não usar `Rails`/`ActiveRecord`/`Sidekiq`/`ViewComponent` ou qualquer outra estrutura que não apareça no código presente.

## Desenvolvimento

- Antes de alterar qualquer comportamento, investigue primeiro a classe equivalente e o padrão de retorno do método.
- Reutilize o código existente em vez de criar nova camada de abstração.
- Para mudanças em integrações SOAP, mantenha o modelo atual: cliente de serviço → chamada SOAP → transformação XML/Hash → retorno consistente.
- Para documentos XML de NF-e, prefira seguir o padrão de `Dataset` e `Templates` em vez de criar estruturas novas e ad hoc.
- Preserve o cuidado com certificados digitais, especialmente `PKCS12`, chaves privadas e arquivos `.pfx`.
- Não registre segredos em log, output ou exemplos.

## Testes

- O framework é `Minitest`.
- A suíte fica em `test/**/*.rb` e usa `require "test_helper"` na maioria dos arquivos.
- O arquivo principal de setup é `test/test_helper.rb`:
  - adiciona `lib` ao `LOAD_PATH`
  - carrega `require "sefaz"`
  - ativa `Minitest::Autorun`
- Os testes usam fixtures em `test/fixtures/` e esperam verificar respostas estruturadas, status codes (`cStat`) e valores conhecidos de XML/Hash.
- Comandos reais do projeto:
  - `bundle install`
  - `bundle exec ruby -Itest test/sefaz/webservice/nfe/test_client.rb`
  - `bundle exec ruby -Itest test/sefaz/webservice/sat/test_client.rb`
  - `bundle exec ruby -Itest test/sefaz/utils/test_signer.rb`
- Sempre que possível, valide com o teste mais próximo do comportamento alterado antes de executar uma suíte maior.

## Dependências

- Reaproveite as dependências já existentes (`savon`, `prawn`, `barby`, `rqrcode`, `br_danfe`, `minitest`).
- Evite adicionar novas bibliotecas para resolver problemas que já estão cobertos pela gem.
- Não substitua ferramentas em uso sem necessidade real e sem evidência no código.

## Execução e validação

- Não existe um servidor web ou aplicação para subir.
- O fluxo operacional principal da gem é a execução de testes e chamadas de métodos de integração contra serviços externos.
- Em termos práticos, a validação mais comum é via Minitest executando os arquivos de teste específicos.
- Quando houver uma alteração em métodos da webservice, valide o arquivo de teste correspondente e, quando relevante, os testes de utilitários relacionados.

## Segurança

- Esse projeto lida com XML fiscal, certificados digitais, arquivos `.pfx`, chaves privadas e comunicação SOAP com autoridades tributárias.
- Nunca inclua certificados ou senhas reais no código, nos fixtures ou nas instruções.
- Evite expor dados sensíveis em mensagens de erro, logs ou exemplos de uso.
- Mantenha a separação entre certificado de transmissão (`@pkcs12Tss`) e certificado de assinatura (`@pkcs12Ass`) quando o código relevante exigir essa distinção.

## Multi-tenancy / banco de dados

- Não há evidência de banco de dados, migrations, ActiveRecord ou isolamento por tenant neste repositório.
- Nenhuma regra de multi-tenancy foi identificada. Não invente uma arquitetura de banco ou tenant para novas implementações.

## CI/CD

- Não foi identificado um workflow de CI/CD em `.github/workflows` neste repositório.
- A validação real do projeto é local e baseada no Minitest.

## Resumo operacional

O Copilot deve agir como um agente que conhece a biblioteca Ruby de integração fiscal do projeto:

- investigar o código existente antes de alterar;
- respeitar a API e nomes já usados;
- preservar XML/hash/retorno do cliente;
- manter o uso de `Savon`, `Dataset`, `Templates` e `Utils` quando aplicável;
- validar com test files específicos do diretório `test/`;
- evitar criar padrões de framework ou arquitetura que não existam no repositório.
