# CHANGELOG

## [Unreleased]

- ConsultarGTIN service
- consultarDistribuicaoDFe service
- consultarDistribuicaoDFeChave service
- enviarManifestacao service
- exportarManifestacao service

## [1.3.0] - 2024-02-29

- Adding SEFAZ::Utils::PrawnHelper with utils methods for Prawn
- Adding layout CupomFiscal55mm/CupomFiscal80mm
- Adding base class to unify printing
- Adding SEFAZ::Webservice::SAT::Client with exportarCF method
- Adding new configuration field
- Adding new exception (ValidationError)
- Adding new refinement (mask!, to_number, numeric?, to_currency, with_delimiter and with_precision)
- Adding prawn gem
- Adding barby gem (with dependencies rqrcode)
- Organizing tests (CFe/NFe and fixtures with examples/results)

## [1.2.0] - 2024-02-24

- Adding SEFAZ::Webservice::SAT::Dataset::Cancel to cancel XML (CFe-SAT)

## [1.1.0] - 2024-02-23

- Adding SEFAZ::Webservice::SAT::Dataset::Sale to sale XML (CFe-SAT)

## [1.0.0] - 2024-02-23

- Major update: Redesign and improvements to the library

## [0.9.0] - 2023-03-22

- Adding SEFAZ::DataSet::NFE object
- Adding enviarNF service
- Adding enviarLoteNF service
- Adding calculaChaveNF service
- Changed: method 'gerarInfRespTec' accepting XML or HASH

## [0.8.0] - 2023-01-16

- Adding enviarCCe service
- Adding exportarCCe service

## [0.7.0] - 2023-01-16

- Adding enviarEvento service
- Adding enviarLoteDeEvento service
- Adding cancelarNF service
- Adding exportarCancelarNF service
- Adding gerarLeiauteEvento method
- Adding global issuer CNPJ
- Fix: method name 'exportarDados'/'enviarDados' to 'exportar'/'enviar'

## [0.6.2] - 2023-01-14

- Fix: turn off warnings when run test
- Fix: wrong comments
- Changed: require ruby version 2.6.0 to 2.5.1 (downgrade)

## [0.6.1] - 2023-01-14

- Fix: fixing wrong signature

## [0.6.0] - 2023-01-12

- Adding technical manager section
- Adding assinarNF service
- Adding inutilizarNF service
- Adding calculaChaveInutilizacao service
- Adding exportarInutilizarNF service
- Adding enviarInutilizarNF service
- Adding validarNF service (<https://www.sefaz.rs.gov.br/NFE/NFE-VAL.aspx>)
- Adding auditarNF service (<https://validador.nfe.tecnospeed.com.br/>)
- Adding gerarDANFE service (<https://www.freenfe.com.br/leitor-de-xml-online>)
- Changed: README.md

## [0.5.1] - 2023-01-12

- Adding helper method (SEFAZ.toXML(@hash), SEFAZ.toHASH(@xml))
- Allowing to services return XML and HASH
- Allowing to SEFAZ::Utils::Connection#call return response object
- Fix: Globals variables
- Fix: Response Savon :LowerCamelCase to :None
- Changed: README.md

## [0.5.0] - 2023-01-11

- consultarRecibo service

## [0.4.1] - 2023-01-11

- Adding README.md
- Allowing to set PFX transmission and signature
- Fix: Nomenclatures
- Fix: Organizations
- Fix: WSDL Service returning only URL

## [0.4.0] - 2023-01-11

- Adding consultarNF service
- Adding consultarCadastro service

## [0.3.1] - 2023-01-10

- Fix: Connection bug with xmlns attribute

## [0.3.0] - 2023-01-10

- Adding WSDL manager
- Adding Connection manager
- Adding module NFE with 'connected?' and 'statusDoServico' service

## [0.2.0] - 2023-01-10

- Adding savon gem

## [0.1.0] - 2023-01-10

- Initial release
