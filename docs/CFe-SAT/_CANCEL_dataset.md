# Lista dos campos do Cancel Dataset

```ruby
# Instanciando objeto Dataset
@dataset = SEFAZ::Webservice::SAT::Dataset::Cancel.new(@chCanc)

# Identificação do Cupom Fiscal Eletrônico
@dataset.ide.CNPJ = ""
@dataset.ide.signAC = ""
@dataset.ide.numeroCaixa = ""

# Gerando o XML e Hash do Dataset
@xml, @hash = @dataset.gerarCF
```
