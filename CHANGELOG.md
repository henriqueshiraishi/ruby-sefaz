## [Unreleased]

- inutilizarNF service
- calculaChaveInutilizacao service
- assinarNota service

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
