# Lista dos campos do Sale Dataset

```ruby
# Instanciando objeto Dataset
@dataset = SEFAZ::Webservice::SAT::Dataset::Sale.new

# Identificação do Cupom Fiscal Eletrônico
@dataset.ide.CNPJ = ""
@dataset.ide.signAC = ""
@dataset.ide.numeroCaixa = ""

# Identificação do Emitente do Cupom Fiscal eletrônico
@dataset.emit.CNPJ = ""
@dataset.emit.IE = ""
@dataset.emit.IM = ""
@dataset.emit.cRegTribISSQN = ""
@dataset.emit.indRatISSQN = ""

# Identificação do Destinatário do Cupom Fiscal Eletrônico
@dataset.dest.CNPJ = ""
@dataset.dest.CPF = ""
@dataset.dest.xNome = ""

# Identificação do Local de Entrega
@dataset.entrega.xLgr = ""
@dataset.entrega.nro = ""
@dataset.entrega.xCpl = ""
@dataset.entrega.xBairro = ""
@dataset.entrega.xMun = ""
@dataset.entrega.UF = ""

# Detalhamento de Produtos e Serviços do CF-e
@dataset.add("DET") do |det|
  # Produtos e Serviços do CF-e
  det.prod.cProd = ""
  det.prod.cEAN = ""
  det.prod.xProd = ""
  det.prod.NCM = ""
  det.prod.CEST = ""
  det.prod.CFOP = ""
  det.prod.uCom = ""
  det.prod.qCom = ""
  det.prod.vUnCom = ""
  det.prod.indRegra = ""
  det.prod.vDesc = ""
  det.prod.vOutro = ""
  det.prod.cANP = ""

  # Grupo do campo de uso livre do Fisco
  @dataset.add("OBSFISCODET") do |obsfiscodet|
    obsfiscodet.xCampoDet = ""
    obsfiscodet.xTextoDet = ""
  end

  # Tributos incidentes no Produto ou Serviço
  det.imposto.vItem12741 = ""

  # ICMS Normal e ST
  # Grupo de Tributação do ICMS = 00,01,12,13,14,20,21,72,73,74,90
  det.imposto.ICMS.ICMS00.Orig = ""
  det.imposto.ICMS.ICMS00.CST = ""
  det.imposto.ICMS.ICMS00.pICMS = ""

  # Grupo de Tributação do ICMS = 30,40,41,60,61
  det.imposto.ICMS.ICMS40.Orig = ""
  det.imposto.ICMS.ICMS40.CST = ""

  # Simples Nacional e CSOSN = 102,300,400,500
  det.imposto.ICMS.ICMSSN102.Orig = ""
  det.imposto.ICMS.ICMSSN102.CSOSN = ""

  # Simples Nacional e CSOSN = 900
  det.imposto.ICMS.ICMSSN900.Orig = ""
  det.imposto.ICMS.ICMSSN900.CSOSN = ""
  det.imposto.ICMS.ICMSSN900.pICMS = ""

  # Grupo do PIS
  # Grupo de PIS tributado pela alíquota
  det.imposto.PIS.PISAliq.CST = ""
  det.imposto.PIS.PISAliq.vBC = ""
  det.imposto.PIS.PISAliq.pPIS = ""

  # Grupo de PIS tributado por Qtde
  det.imposto.PIS.PISQtde.CST = ""
  det.imposto.PIS.PISQtde.qBCProd = ""
  det.imposto.PIS.PISQtde.vAliqProd = ""

  # Grupo de PIS não tributado
  det.imposto.PIS.PISNT.CST = ""

  # Grupo de PIS para contribuinte do SIMPLES NACIONAL
  det.imposto.PIS.PISSN.CST = ""

  # Grupo de PIS Outras Operações
  det.imposto.PIS.PISOutr.CST = ""
  det.imposto.PIS.PISOutr.vBC = ""
  det.imposto.PIS.PISOutr.pPIS = ""
  det.imposto.PIS.PISOutr.qBCProd = ""
  det.imposto.PIS.PISOutr.vAliqProd = ""

  # Grupo de PIS Substituição Tributária
  det.imposto.PISST.vBC = ""
  det.imposto.PISST.pPIS = ""
  det.imposto.PISST.qBCProd = ""
  det.imposto.PISST.vAliqProd = ""

  # Grupo do COFINS
  # Grupo de COFINS tributado pela alíquota
  det.imposto.COFINS.COFINSAliq.CST = ""
  det.imposto.COFINS.COFINSAliq.vBC = ""
  det.imposto.COFINS.COFINSAliq.pCOFINS = ""

  # Grupo de COFINS tributado por Qtde
  det.imposto.COFINS.COFINSQtde.CST = ""
  det.imposto.COFINS.COFINSQtde.qBCProd = ""
  det.imposto.COFINS.COFINSQtde.vAliqProd = ""

  # Grupo de COFINS não tributado
  det.imposto.COFINS.COFINSNT.CST = ""

  # Grupo de COFINS para contribuinte do SIMPLES NACIONAL
  det.imposto.COFINS.COFINSSN.CST = ""

  # Grupo de COFINS Outras Operações
  det.imposto.COFINS.COFINSOutr.CST = ""
  det.imposto.COFINS.COFINSOutr.vBC = ""
  det.imposto.COFINS.COFINSOutr.pCOFINS = ""
  det.imposto.COFINS.COFINSOutr.qBCProd = ""
  det.imposto.COFINS.COFINSOutr.vAliqProd = ""

  # Grupo de COFINS Substituição Tributária
  det.imposto.COFINSST.vBC = ""
  det.imposto.COFINSST.pCOFINS = ""
  det.imposto.COFINSST.qBCProd = ""
  det.imposto.COFINSST.vAliqProd = ""

  # Grupo do ISSQN
  det.imposto.ISSQN.vDeducISSQN = ""
  det.imposto.ISSQN.vAliq = ""
  det.imposto.ISSQN.cMunFG = ""
  det.imposto.ISSQN.cListServ = ""
  det.imposto.ISSQN.cServTribMun = ""
  det.imposto.ISSQN.cNatOp = ""
  det.imposto.ISSQN.indIncFisc = ""

  # Informações adicionais
  det.infAdProd = ""
end

# Valores Totais do CF-e
@dataset.total.vCFeLei12741 = ""

# Grupo de valores de entrada de Desconto/Acréscimo sobre Subtotal
@dataset.total.DescAcrEntr.vDescSubtot = ""
@dataset.total.DescAcrEntr.vAcresSubtot = ""

# Informações sobre Pagamento
# Grupo de informações dos Meios de Pagamento empregados na quitação do CF-e
@dataset.add("MP") do |mp|
  mp.cMP = ""
  mp.vMP = ""
  mp.cAdmC = ""
  mp.cAut = ""
end

# Grupo de Informações Adicionais
@dataset.infAdic.infCpl = ""

# Gerando o XML e Hash do Dataset
@xml, @hash = @dataset.gerarCF
```
