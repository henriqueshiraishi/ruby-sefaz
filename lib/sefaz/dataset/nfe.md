# Lista dos campos do DataSet

```ruby
# Instanciando objeto DataSet
@dataSet = SEFAZ::DataSet::NFE.new(@chaveNF)

# Identificação da NF
@dataSet.ide.cUF = ""
@dataSet.ide.cNF = ""
@dataSet.ide.natOp = ""
@dataSet.ide.mod = ""
@dataSet.ide.serie = ""
@dataSet.ide.nNF = ""
@dataSet.ide.dhEmi = ""
@dataSet.ide.dhSaiEnt = ""
@dataSet.ide.tpNF = ""
@dataSet.ide.idDest = ""
@dataSet.ide.cMunFG = ""
@dataSet.ide.tpImp = ""
@dataSet.ide.tpEmis = ""
@dataSet.ide.cDV = ""
@dataSet.ide.tpAmb = ""
@dataSet.ide.finNFe = ""
@dataSet.ide.indFinal = ""
@dataSet.ide.indPres = ""
@dataSet.ide.indIntermed = ""
@dataSet.ide.procEmi = ""
@dataSet.ide.verProc = ""
@dataSet.ide.dhCont = ""
@dataSet.ide.xJust = ""

# NF referenciadas
@dataSet.incluirParte("NFREF")
  @dataSet.NFref.refNFe = ""
  @dataSet.NFref.cUF = ""
  @dataSet.NFref.AAMM = ""
  @dataSet.NFref.CNPJ = ""
  @dataSet.NFref.CPF = ""
  @dataSet.NFref.IE = ""
  @dataSet.NFref.mod = ""
  @dataSet.NFref.serie = ""
  @dataSet.NFref.nNF = ""
  @dataSet.NFref.refCTe = ""
  @dataSet.NFref.nECF = ""
  @dataSet.NFref.nCOO = ""
@dataSet.salvarParte("NFREF")

# Dados do emitente
@dataSet.emit.CNPJ = ""
@dataSet.emit.CPF = ""
@dataSet.emit.xNome = ""
@dataSet.emit.xFant = ""
@dataSet.emit.enderEmit.xLgr = ""
@dataSet.emit.enderEmit.nro = ""
@dataSet.emit.enderEmit.xCpl = ""
@dataSet.emit.enderEmit.xBairro = ""
@dataSet.emit.enderEmit.cMun = ""
@dataSet.emit.enderEmit.xMun = ""
@dataSet.emit.enderEmit.UF = ""
@dataSet.emit.enderEmit.CEP = ""
@dataSet.emit.enderEmit.cPais = ""
@dataSet.emit.enderEmit.xPais = ""
@dataSet.emit.enderEmit.fon = ""
@dataSet.emit.IE = ""
@dataSet.emit.IEST = ""
@dataSet.emit.IM = ""
@dataSet.emit.CNAE = ""
@dataSet.emit.CRT = ""

# NF avulsa
@dataSet.avulsa.CNPJ = ""
@dataSet.avulsa.xOrgao = ""
@dataSet.avulsa.matr = ""
@dataSet.avulsa.xAgente = ""
@dataSet.avulsa.fone = ""
@dataSet.avulsa.UF = ""
@dataSet.avulsa.nDAR = ""
@dataSet.avulsa.dEmi = ""
@dataSet.avulsa.vDAR = ""
@dataSet.avulsa.repEmi = ""
@dataSet.avulsa.dPag = ""

# Dados do destinatário
@dataSet.dest.CNPJ = ""
@dataSet.dest.CPF = ""
@dataSet.dest.idEstrangeiro = ""
@dataSet.dest.xNome = ""
@dataSet.dest.enderDest.xLgr = ""
@dataSet.dest.enderDest.nro = ""
@dataSet.dest.enderDest.xCpl = ""
@dataSet.dest.enderDest.xBairro = ""
@dataSet.dest.enderDest.cMun = ""
@dataSet.dest.enderDest.xMun = ""
@dataSet.dest.enderDest.UF = ""
@dataSet.dest.enderDest.CEP = ""
@dataSet.dest.enderDest.cPais = ""
@dataSet.dest.enderDest.xPais = ""
@dataSet.dest.enderDest.fon = ""
@dataSet.dest.indIEDest = ""
@dataSet.dest.IE = ""
@dataSet.dest.ISUF = ""
@dataSet.dest.IM = ""
@dataSet.dest.email = ""

# Local de retirada
@dataSet.retirada.CNPJ = ""
@dataSet.retirada.CPF = ""
@dataSet.retirada.xNome = ""
@dataSet.retirada.xLgr = ""
@dataSet.retirada.nro = ""
@dataSet.retirada.xCpl = ""
@dataSet.retirada.xBairro = ""
@dataSet.retirada.cMun = ""
@dataSet.retirada.xMun = ""
@dataSet.retirada.UF = ""
@dataSet.retirada.CEP = ""
@dataSet.retirada.cPais = ""
@dataSet.retirada.xPais = ""
@dataSet.retirada.fone = ""
@dataSet.retirada.email = ""
@dataSet.retirada.IE = ""

# Local de entrega
@dataSet.entrega.CNPJ = ""
@dataSet.entrega.CPF = ""
@dataSet.entrega.xNome = ""
@dataSet.entrega.xLgr = ""
@dataSet.entrega.nro = ""
@dataSet.entrega.xCpl = ""
@dataSet.entrega.xBairro = ""
@dataSet.entrega.cMun = ""
@dataSet.entrega.xMun = ""
@dataSet.entrega.UF = ""
@dataSet.entrega.CEP = ""
@dataSet.entrega.cPais = ""
@dataSet.entrega.xPais = ""
@dataSet.entrega.fone = ""
@dataSet.entrega.email = ""
@dataSet.entrega.IE = ""

# Autorização de acesso
@dataSet.incluirParte("AUTXML")
  @dataSet.autXML.CNPJ = ""
  @dataSet.autXML.CPF = ""
@dataSet.salvarParte("AUTXML")

# Detalhamento do item
@dataSet.incluirParte("DET")
  # Dados do produto
  @dataSet.det.prod.cProd = ""
  @dataSet.det.prod.cEAN = ""
  @dataSet.det.prod.xProd = ""
  @dataSet.det.prod.NCM = ""
  @dataSet.det.prod.NVE = ""
  @dataSet.det.prod.CEST = ""
  @dataSet.det.prod.indEscala = ""
  @dataSet.det.prod.CNPJFab = ""
  @dataSet.det.prod.cBenef = ""
  @dataSet.det.prod.EXTIPI = ""
  @dataSet.det.prod.CFOP = ""
  @dataSet.det.prod.uCom = ""
  @dataSet.det.prod.qCom = ""
  @dataSet.det.prod.vUnCom = ""
  @dataSet.det.prod.vProd = ""
  @dataSet.det.prod.cEANTrib = ""
  @dataSet.det.prod.uTrib = ""
  @dataSet.det.prod.qTrib = ""
  @dataSet.det.prod.vUnTrib = ""
  @dataSet.det.prod.vFrete = ""
  @dataSet.det.prod.vSeg = ""
  @dataSet.det.prod.vDesc = ""
  @dataSet.det.prod.vOutro = ""
  @dataSet.det.prod.indTot = ""
  @dataSet.det.prod.xPed = ""
  @dataSet.det.prod.nItemPed = ""
  @dataSet.det.prod.nFCI = ""
  @dataSet.det.prod.nRECOPI = ""

  # Importação
  @dataSet.incluirParte("DI")
    @dataSet.DI.nDI = ""
    @dataSet.DI.dDI = ""
    @dataSet.DI.xLocDesemb = ""
    @dataSet.DI.UFDesemb = ""
    @dataSet.DI.dDesemb = ""
    @dataSet.DI.tpViaTransp = ""
    @dataSet.DI.vAFRMM = ""
    @dataSet.DI.tpIntermedio = ""
    @dataSet.DI.CNPJ = ""
    @dataSet.DI.UFTerceiro = ""
    @dataSet.DI.cExportador = ""

    # Adições
    @dataSet.incluirParte("ADI")
      @dataSet.adi.nAdicao = "" 
      @dataSet.adi.nSeqAdic = "" 
      @dataSet.adi.cFabricante = "" 
      @dataSet.adi.vDescDI = "" 
      @dataSet.adi.nDraw = ""
    @dataSet.salvarParte("ADI")
  @dataSet.salvarParte("DI")

  # Exportação
  @dataSet.incluirParte("DETEXPORT")
    @dataSet.detExport.nDraw = ""
    @dataSet.detExport.exportInd.nRE = ""
    @dataSet.detExport.exportInd.chNFe = ""
    @dataSet.detExport.exportInd.qExport = ""
  @dataSet.salvarParte("DETEXPORT")

  # Rastreabilidade
  @dataSet.incluirParte("RASTRO")
    @dataSet.rastro.nLote = ""
    @dataSet.rastro.qLote = ""
    @dataSet.rastro.dFab = ""
    @dataSet.rastro.dVal = ""
    @dataSet.rastro.cAgreg = ""
  @dataSet.salvarParte("RASTRO")

  # Detalhamento de veículos
  @dataSet.det.prod.veicProd.tpOp = ""
  @dataSet.det.prod.veicProd.chassi = ""
  @dataSet.det.prod.veicProd.cCor = ""
  @dataSet.det.prod.veicProd.xCor = ""
  @dataSet.det.prod.veicProd.pot = ""
  @dataSet.det.prod.veicProd.cilin = ""
  @dataSet.det.prod.veicProd.pesoL = ""
  @dataSet.det.prod.veicProd.pesoB = ""
  @dataSet.det.prod.veicProd.nSerie = ""
  @dataSet.det.prod.veicProd.tpComb = ""
  @dataSet.det.prod.veicProd.nMotor = ""
  @dataSet.det.prod.veicProd.CMT = ""
  @dataSet.det.prod.veicProd.dist = ""
  @dataSet.det.prod.veicProd.anoMod = ""
  @dataSet.det.prod.veicProd.anoFab = ""
  @dataSet.det.prod.veicProd.tpPint = ""
  @dataSet.det.prod.veicProd.tpVeic = ""
  @dataSet.det.prod.veicProd.espVeic = ""
  @dataSet.det.prod.veicProd.VIN = ""
  @dataSet.det.prod.veicProd.condVeic = ""
  @dataSet.det.prod.veicProd.cMod = ""
  @dataSet.det.prod.veicProd.cCorDENATRAN = ""
  @dataSet.det.prod.veicProd.lota = ""
  @dataSet.det.prod.veicProd.tpRest = ""

  # Detalhamento de medicamentos
  @dataSet.det.prod.med.cProdANVISA = ""
  @dataSet.det.prod.med.xMotivoIsencao = ""
  @dataSet.det.prod.med.vPMC = ""

  # Detalhamento de armamento
  @dataSet.incluirParte("ARMA")
    @dataSet.arma.tpArma = ""
    @dataSet.arma.nSerie = ""
    @dataSet.arma.nCano = ""
    @dataSet.arma.descr = ""
  @dataSet.salvarParte("ARMA")

  # Informações específicas para combustíveis
  @dataSet.det.prod.comb.cProdANP = ""
  @dataSet.det.prod.comb.descANP = ""
  @dataSet.det.prod.comb.pGLP = ""
  @dataSet.det.prod.comb.pGNn = ""
  @dataSet.det.prod.comb.pGNi = ""
  @dataSet.det.prod.comb.vPart = ""
  @dataSet.det.prod.comb.CODIF = ""
  @dataSet.det.prod.comb.qTemp = ""
  @dataSet.det.prod.comb.UFCons = "" 
  @dataSet.det.prod.comb.CIDE.qBCProd = ""
  @dataSet.det.prod.comb.CIDE.vAliqProd = ""
  @dataSet.det.prod.comb.CIDE.vCIDE = ""
  @dataSet.det.prod.comb.encerrante.nBico = ""
  @dataSet.det.prod.comb.encerrante.nBomba = ""
  @dataSet.det.prod.comb.encerrante.nTanque = ""
  @dataSet.det.prod.comb.encerrante.vEncIni = ""
  @dataSet.det.prod.comb.encerrante.vEncFin = ""

  # Dados dos impostos
  @dataSet.det.imposto.vTotTrib = ""
  
  # Dados do ICMS
  # ICMS 00
  @dataSet.det.imposto.ICMS.ICMS00.orig = ""
  @dataSet.det.imposto.ICMS.ICMS00.CST = ""
  @dataSet.det.imposto.ICMS.ICMS00.modBC = ""
  @dataSet.det.imposto.ICMS.ICMS00.vBC = ""
  @dataSet.det.imposto.ICMS.ICMS00.pICMS = ""
  @dataSet.det.imposto.ICMS.ICMS00.vICMS = ""
  @dataSet.det.imposto.ICMS.ICMS00.pFCP = ""
  @dataSet.det.imposto.ICMS.ICMS00.vFCP = ""

  # ICMS 10
  @dataSet.det.imposto.ICMS.ICMS10.orig = ""
  @dataSet.det.imposto.ICMS.ICMS10.CST = ""
  @dataSet.det.imposto.ICMS.ICMS10.modBC = ""
  @dataSet.det.imposto.ICMS.ICMS10.vBC = ""
  @dataSet.det.imposto.ICMS.ICMS10.pICMS = ""
  @dataSet.det.imposto.ICMS.ICMS10.vICMS = ""
  @dataSet.det.imposto.ICMS.ICMS10.vBCFCP = ""
  @dataSet.det.imposto.ICMS.ICMS10.pFCP = ""
  @dataSet.det.imposto.ICMS.ICMS10.vFCP = ""
  @dataSet.det.imposto.ICMS.ICMS10.modBCST = ""
  @dataSet.det.imposto.ICMS.ICMS10.pMVAST = ""
  @dataSet.det.imposto.ICMS.ICMS10.pRedBCST = ""
  @dataSet.det.imposto.ICMS.ICMS10.vBCST = ""
  @dataSet.det.imposto.ICMS.ICMS10.pICMSST = ""
  @dataSet.det.imposto.ICMS.ICMS10.vICMSST = ""
  @dataSet.det.imposto.ICMS.ICMS10.vBCFCPST = ""
  @dataSet.det.imposto.ICMS.ICMS10.pFCPST = ""
  @dataSet.det.imposto.ICMS.ICMS10.vFCPST = ""

  # ICMS 20
  @dataSet.det.imposto.ICMS.ICMS20.orig = ""
  @dataSet.det.imposto.ICMS.ICMS20.CST = ""
  @dataSet.det.imposto.ICMS.ICMS20.modBC = ""
  @dataSet.det.imposto.ICMS.ICMS20.pRedBC = ""
  @dataSet.det.imposto.ICMS.ICMS20.vBC = ""
  @dataSet.det.imposto.ICMS.ICMS20.pICMS = ""
  @dataSet.det.imposto.ICMS.ICMS20.vICMS = ""
  @dataSet.det.imposto.ICMS.ICMS20.vBCFCP = ""
  @dataSet.det.imposto.ICMS.ICMS20.pFCP = ""
  @dataSet.det.imposto.ICMS.ICMS20.vFCP = ""
  @dataSet.det.imposto.ICMS.ICMS20.vICMSDeson = ""
  @dataSet.det.imposto.ICMS.ICMS20.motDesICMS = ""

  # ICMS 30
  @dataSet.det.imposto.ICMS.ICMS30.orig = ""
  @dataSet.det.imposto.ICMS.ICMS30.CST = ""
  @dataSet.det.imposto.ICMS.ICMS30.modBCST = ""
  @dataSet.det.imposto.ICMS.ICMS30.pMVAST = ""
  @dataSet.det.imposto.ICMS.ICMS30.pRedBCST = ""
  @dataSet.det.imposto.ICMS.ICMS30.vBCST = ""
  @dataSet.det.imposto.ICMS.ICMS30.pICMSST = ""
  @dataSet.det.imposto.ICMS.ICMS30.vICMSST = ""
  @dataSet.det.imposto.ICMS.ICMS30.vBCFCPST = ""
  @dataSet.det.imposto.ICMS.ICMS30.pFCPST = ""
  @dataSet.det.imposto.ICMS.ICMS30.vFCPST = ""
  @dataSet.det.imposto.ICMS.ICMS30.vICMSDeson = ""
  @dataSet.det.imposto.ICMS.ICMS30.motDesICMS = ""

  # ICMS 40
  @dataSet.det.imposto.ICMS.ICMS40.orig = ""
  @dataSet.det.imposto.ICMS.ICMS40.CST = ""
  @dataSet.det.imposto.ICMS.ICMS40.vICMSDeson = ""
  @dataSet.det.imposto.ICMS.ICMS40.motDesICMS = ""

  # ICMS 51
  @dataSet.det.imposto.ICMS.ICMS51.orig = ""
  @dataSet.det.imposto.ICMS.ICMS51.CST = ""
  @dataSet.det.imposto.ICMS.ICMS51.modBC = ""
  @dataSet.det.imposto.ICMS.ICMS51.pRedBC = ""
  @dataSet.det.imposto.ICMS.ICMS51.vBC = ""
  @dataSet.det.imposto.ICMS.ICMS51.pICMS = ""
  @dataSet.det.imposto.ICMS.ICMS51.vICMSOp = ""
  @dataSet.det.imposto.ICMS.ICMS51.pDif = ""
  @dataSet.det.imposto.ICMS.ICMS51.vICMSDif = ""
  @dataSet.det.imposto.ICMS.ICMS51.vICMS = ""
  @dataSet.det.imposto.ICMS.ICMS51.vBCFCP = ""
  @dataSet.det.imposto.ICMS.ICMS51.pFCP = ""
  @dataSet.det.imposto.ICMS.ICMS51.vFCP = ""

  # ICMS 60
  @dataSet.det.imposto.ICMS.ICMS60.orig = ""
  @dataSet.det.imposto.ICMS.ICMS60.CST = ""
  @dataSet.det.imposto.ICMS.ICMS60.vBCSTRet = ""
  @dataSet.det.imposto.ICMS.ICMS60.pST = ""
  @dataSet.det.imposto.ICMS.ICMS60.vICMSSubstituto = ""
  @dataSet.det.imposto.ICMS.ICMS60.vICMSSTRet = ""
  @dataSet.det.imposto.ICMS.ICMS60.vBCFCPSTRet = ""
  @dataSet.det.imposto.ICMS.ICMS60.pFCPSTRet = ""
  @dataSet.det.imposto.ICMS.ICMS60.vFCPSTRet = ""
  @dataSet.det.imposto.ICMS.ICMS60.pRedBCEfet = ""
  @dataSet.det.imposto.ICMS.ICMS60.vBCEfet = ""
  @dataSet.det.imposto.ICMS.ICMS60.pICMSEfet = ""
  @dataSet.det.imposto.ICMS.ICMS60.vICMSEfet = ""

  # ICMS 70
  @dataSet.det.imposto.ICMS.ICMS70.orig = ""
  @dataSet.det.imposto.ICMS.ICMS70.CST = ""
  @dataSet.det.imposto.ICMS.ICMS70.modBC = ""
  @dataSet.det.imposto.ICMS.ICMS70.pRedBC = ""
  @dataSet.det.imposto.ICMS.ICMS70.vBC = ""
  @dataSet.det.imposto.ICMS.ICMS70.pICMS = ""
  @dataSet.det.imposto.ICMS.ICMS70.vICMS = ""
  @dataSet.det.imposto.ICMS.ICMS70.vBCFCP = ""
  @dataSet.det.imposto.ICMS.ICMS70.pFCP = ""
  @dataSet.det.imposto.ICMS.ICMS70.vFCP = ""
  @dataSet.det.imposto.ICMS.ICMS70.modBCST = ""
  @dataSet.det.imposto.ICMS.ICMS70.pMVAST = ""
  @dataSet.det.imposto.ICMS.ICMS70.pRedBCST = ""
  @dataSet.det.imposto.ICMS.ICMS70.vBCST = ""
  @dataSet.det.imposto.ICMS.ICMS70.pICMSST = ""
  @dataSet.det.imposto.ICMS.ICMS70.vICMSST = ""
  @dataSet.det.imposto.ICMS.ICMS70.vBCFCPST = ""
  @dataSet.det.imposto.ICMS.ICMS70.pFCPST = ""
  @dataSet.det.imposto.ICMS.ICMS70.vFCPST = ""
  @dataSet.det.imposto.ICMS.ICMS70.vICMSDeson = ""
  @dataSet.det.imposto.ICMS.ICMS70.motDesICMS = ""

  # ICMS 90
  @dataSet.det.imposto.ICMS.ICMS90.orig = ""
  @dataSet.det.imposto.ICMS.ICMS90.CST = ""
  @dataSet.det.imposto.ICMS.ICMS90.modBC = ""
  @dataSet.det.imposto.ICMS.ICMS90.vBC = ""
  @dataSet.det.imposto.ICMS.ICMS90.pRedBC = ""
  @dataSet.det.imposto.ICMS.ICMS90.pICMS = ""
  @dataSet.det.imposto.ICMS.ICMS90.vICMS = ""
  @dataSet.det.imposto.ICMS.ICMS90.vBCFCP = ""
  @dataSet.det.imposto.ICMS.ICMS90.pFCP = ""
  @dataSet.det.imposto.ICMS.ICMS90.vFCP = ""
  @dataSet.det.imposto.ICMS.ICMS90.modBCST = ""
  @dataSet.det.imposto.ICMS.ICMS90.pMVAST = ""
  @dataSet.det.imposto.ICMS.ICMS90.pRedBCST = ""
  @dataSet.det.imposto.ICMS.ICMS90.vBCST = ""
  @dataSet.det.imposto.ICMS.ICMS90.pICMSST = ""
  @dataSet.det.imposto.ICMS.ICMS90.vICMSST = ""
  @dataSet.det.imposto.ICMS.ICMS90.vBCFCPST = ""
  @dataSet.det.imposto.ICMS.ICMS90.pFCPST = ""
  @dataSet.det.imposto.ICMS.ICMS90.vFCPST = ""
  @dataSet.det.imposto.ICMS.ICMS90.vICMSDeson = ""
  @dataSet.det.imposto.ICMS.ICMS90.motDesICMS = ""

  # Grupo de Partilha do ICMS
  @dataSet.det.imposto.ICMS.ICMSPart.orig = ""
  @dataSet.det.imposto.ICMS.ICMSPart.CST = ""
  @dataSet.det.imposto.ICMS.ICMSPart.modBC = ""
  @dataSet.det.imposto.ICMS.ICMSPart.vBC = ""
  @dataSet.det.imposto.ICMS.ICMSPart.pRedBC = ""
  @dataSet.det.imposto.ICMS.ICMSPart.pICMS = ""
  @dataSet.det.imposto.ICMS.ICMSPart.vICMS = ""
  @dataSet.det.imposto.ICMS.ICMSPart.modBCST = ""
  @dataSet.det.imposto.ICMS.ICMSPart.pMVAST = ""
  @dataSet.det.imposto.ICMS.ICMSPart.pRedBCST = ""
  @dataSet.det.imposto.ICMS.ICMSPart.vBCST = ""
  @dataSet.det.imposto.ICMS.ICMSPart.pICMSST = ""
  @dataSet.det.imposto.ICMS.ICMSPart.vICMSST = ""
  @dataSet.det.imposto.ICMS.ICMSPart.pBCOp = ""
  @dataSet.det.imposto.ICMS.ICMSPart.UFST = ""

  # Grupo de Repasse de ICMS ST
  @dataSet.det.imposto.ICMS.ICMSST.orig = ""
  @dataSet.det.imposto.ICMS.ICMSST.CST = ""
  @dataSet.det.imposto.ICMS.ICMSST.vBCSTRet = ""
  @dataSet.det.imposto.ICMS.ICMSST.pST = ""
  @dataSet.det.imposto.ICMS.ICMSST.vICMSSubstituto = ""
  @dataSet.det.imposto.ICMS.ICMSST.vICMSSTRet = ""
  @dataSet.det.imposto.ICMS.ICMSST.vBCFCPSTRet = ""
  @dataSet.det.imposto.ICMS.ICMSST.pFCPSTRet = ""
  @dataSet.det.imposto.ICMS.ICMSST.vFCPSTRet = ""
  @dataSet.det.imposto.ICMS.ICMSST.vBCSTDest = ""
  @dataSet.det.imposto.ICMS.ICMSST.vICMSSTDest = ""
  @dataSet.det.imposto.ICMS.ICMSST.pRedBCEfet = ""
  @dataSet.det.imposto.ICMS.ICMSST.vBCEfet = ""
  @dataSet.det.imposto.ICMS.ICMSST.pICMSEfet = ""
  @dataSet.det.imposto.ICMS.ICMSST.vICMSEfet = ""

  # CSOSN 101
  @dataSet.det.imposto.ICMS.ICMSSN101.orig = ""
  @dataSet.det.imposto.ICMS.ICMSSN101.CSOSN = ""
  @dataSet.det.imposto.ICMS.ICMSSN101.pCredSN = ""
  @dataSet.det.imposto.ICMS.ICMSSN101.vCredICMSSN = ""

  # CSOSN 102
  @dataSet.det.imposto.ICMS.ICMSSN102.orig = ""
  @dataSet.det.imposto.ICMS.ICMSSN102.CSOSN = ""

  # CSOSN 201
  @dataSet.det.imposto.ICMS.ICMSSN201.orig = ""
  @dataSet.det.imposto.ICMS.ICMSSN201.CSOSN = ""
  @dataSet.det.imposto.ICMS.ICMSSN201.modBCST = ""
  @dataSet.det.imposto.ICMS.ICMSSN201.pMVAST = ""
  @dataSet.det.imposto.ICMS.ICMSSN201.pRedBCST = ""
  @dataSet.det.imposto.ICMS.ICMSSN201.vBCST = ""
  @dataSet.det.imposto.ICMS.ICMSSN201.pICMSST = ""
  @dataSet.det.imposto.ICMS.ICMSSN201.vICMSST = ""
  @dataSet.det.imposto.ICMS.ICMSSN201.vBCFCPST = ""
  @dataSet.det.imposto.ICMS.ICMSSN201.pFCPST = ""
  @dataSet.det.imposto.ICMS.ICMSSN201.vFCPST = ""
  @dataSet.det.imposto.ICMS.ICMSSN201.pCredSN = ""
  @dataSet.det.imposto.ICMS.ICMSSN201.vCredICMSSN = ""

  # CSOSN 202
  @dataSet.det.imposto.ICMS.ICMSSN202.orig = ""
  @dataSet.det.imposto.ICMS.ICMSSN202.CSOSN = ""
  @dataSet.det.imposto.ICMS.ICMSSN202.modBCST = ""
  @dataSet.det.imposto.ICMS.ICMSSN202.pMVAST = ""
  @dataSet.det.imposto.ICMS.ICMSSN202.pRedBCST = ""
  @dataSet.det.imposto.ICMS.ICMSSN202.vBCST = ""
  @dataSet.det.imposto.ICMS.ICMSSN202.pICMSST = ""
  @dataSet.det.imposto.ICMS.ICMSSN202.vICMSST = ""
  @dataSet.det.imposto.ICMS.ICMSSN202.vBCFCPST = ""
  @dataSet.det.imposto.ICMS.ICMSSN202.pFCPST = ""
  @dataSet.det.imposto.ICMS.ICMSSN202.vFCPST = ""

  # CSOSN 500
  @dataSet.det.imposto.ICMS.ICMSSN500.orig = ""
  @dataSet.det.imposto.ICMS.ICMSSN500.CSOSN = ""
  @dataSet.det.imposto.ICMS.ICMSSN500.vBCSTRet = ""
  @dataSet.det.imposto.ICMS.ICMSSN500.pST = ""
  @dataSet.det.imposto.ICMS.ICMSSN500.vICMSSubstituto = ""
  @dataSet.det.imposto.ICMS.ICMSSN500.vICMSSTRet = ""
  @dataSet.det.imposto.ICMS.ICMSSN500.vBCFCPSTRet = ""
  @dataSet.det.imposto.ICMS.ICMSSN500.pFCPSTRet = ""
  @dataSet.det.imposto.ICMS.ICMSSN500.vFCPSTRet = ""
  @dataSet.det.imposto.ICMS.ICMSSN500.pRedBCEfet = ""
  @dataSet.det.imposto.ICMS.ICMSSN500.vBCEfet = ""
  @dataSet.det.imposto.ICMS.ICMSSN500.pICMSEfet = ""
  @dataSet.det.imposto.ICMS.ICMSSN500.vICMSEfet = ""

  # CSOSN 900
  @dataSet.det.imposto.ICMS.ICMSSN900.orig = ""
  @dataSet.det.imposto.ICMS.ICMSSN900.CSOSN = ""
  @dataSet.det.imposto.ICMS.ICMSSN900.modBC = ""
  @dataSet.det.imposto.ICMS.ICMSSN900.vBC = ""
  @dataSet.det.imposto.ICMS.ICMSSN900.pRedBC = ""
  @dataSet.det.imposto.ICMS.ICMSSN900.pICMS = ""
  @dataSet.det.imposto.ICMS.ICMSSN900.vICMS = ""
  @dataSet.det.imposto.ICMS.ICMSSN900.modBCST = ""
  @dataSet.det.imposto.ICMS.ICMSSN900.pMVAST = ""
  @dataSet.det.imposto.ICMS.ICMSSN900.pRedBCST = ""
  @dataSet.det.imposto.ICMS.ICMSSN900.vBCST = ""
  @dataSet.det.imposto.ICMS.ICMSSN900.pICMSST = ""
  @dataSet.det.imposto.ICMS.ICMSSN900.vICMSST = ""
  @dataSet.det.imposto.ICMS.ICMSSN900.vBCFCPST = ""
  @dataSet.det.imposto.ICMS.ICMSSN900.pFCPST = ""
  @dataSet.det.imposto.ICMS.ICMSSN900.vFCPST = ""
  @dataSet.det.imposto.ICMS.ICMSSN900.pCredSN = ""
  @dataSet.det.imposto.ICMS.ICMSSN900.vCredICMSSN = ""

  # Informação do ICMS interestadual
  @dataSet.det.imposto.ICMSUFDest.vBCUFDest = ""
  @dataSet.det.imposto.ICMSUFDest.vBCFCPUFDest = ""
  @dataSet.det.imposto.ICMSUFDest.pFCPUFDest = ""
  @dataSet.det.imposto.ICMSUFDest.pICMSUFDest = ""
  @dataSet.det.imposto.ICMSUFDest.pICMSInter = ""
  @dataSet.det.imposto.ICMSUFDest.pICMSInterPart = ""
  @dataSet.det.imposto.ICMSUFDest.vFCPUFDest = ""
  @dataSet.det.imposto.ICMSUFDest.vICMSUFDest = ""
  @dataSet.det.imposto.ICMSUFDest.vICMSUFRemet = ""
  
  # IPI
  @dataSet.det.imposto.IPI.CNPJProd = ""
  @dataSet.det.imposto.IPI.cSelo = ""
  @dataSet.det.imposto.IPI.qSelo = ""
  @dataSet.det.imposto.IPI.cEnq = ""
  @dataSet.det.imposto.IPI.IPITrib.CST = ""
  @dataSet.det.imposto.IPI.IPITrib.vBC = ""
  @dataSet.det.imposto.IPI.IPITrib.qUnid = ""
  @dataSet.det.imposto.IPI.IPITrib.vUnid = ""
  @dataSet.det.imposto.IPI.IPITrib.vIPI = ""
  @dataSet.det.imposto.IPI.IPINT.CST = ""

  # II
  @dataSet.det.imposto.II.vBC = ""
  @dataSet.det.imposto.II.vDespAdu = ""
  @dataSet.det.imposto.II.vII = ""
  @dataSet.det.imposto.II.vIOF = ""

  # PIS
  @dataSet.det.imposto.PIS.PISAliq.CST = ""
  @dataSet.det.imposto.PIS.PISAliq.vBC = ""
  @dataSet.det.imposto.PIS.PISAliq.pPIS = ""
  @dataSet.det.imposto.PIS.PISAliq.vPIS = ""
  @dataSet.det.imposto.PIS.PISQtde.CST = ""
  @dataSet.det.imposto.PIS.PISQtde.qBCProd = ""
  @dataSet.det.imposto.PIS.PISQtde.vAliqProd = ""
  @dataSet.det.imposto.PIS.PISQtde.vPIS = ""
  @dataSet.det.imposto.PIS.PISNT.CST = ""
  @dataSet.det.imposto.PIS.PISOutr.CST = ""
  @dataSet.det.imposto.PIS.PISOutr.vBC = ""
  @dataSet.det.imposto.PIS.PISOutr.pPIS = ""
  @dataSet.det.imposto.PIS.PISOutr.qBCProd = ""
  @dataSet.det.imposto.PIS.PISOutr.vAliqProd = ""
  @dataSet.det.imposto.PIS.PISOutr.vPIS = ""

  # PISST
  @dataSet.det.imposto.PISST.vBC = ""
  @dataSet.det.imposto.PISST.pPIS = ""
  @dataSet.det.imposto.PISST.qBCProd = ""
  @dataSet.det.imposto.PISST.vAliqProd = ""
  @dataSet.det.imposto.PISST.vPIS = ""

  # COFINS
  @dataSet.det.imposto.COFINS.COFINSAliq.CST = ""
  @dataSet.det.imposto.COFINS.COFINSAliq.vBC = ""
  @dataSet.det.imposto.COFINS.COFINSAliq.pCOFINS = ""
  @dataSet.det.imposto.COFINS.COFINSAliq.vCOFINS = ""
  @dataSet.det.imposto.COFINS.COFINSQtde.CST = ""
  @dataSet.det.imposto.COFINS.COFINSQtde.qBCProd = ""
  @dataSet.det.imposto.COFINS.COFINSQtde.vAliqProd = ""
  @dataSet.det.imposto.COFINS.COFINSQtde.vCOFINS ""
  @dataSet.det.imposto.COFINS.COFINSNT.CST = ""
  @dataSet.det.imposto.COFINS.COFINSOutr.CST = ""
  @dataSet.det.imposto.COFINS.COFINSOutr.vBC = ""
  @dataSet.det.imposto.COFINS.COFINSOutr.pCOFINS = ""
  @dataSet.det.imposto.COFINS.COFINSOutr.qBCProd = ""
  @dataSet.det.imposto.COFINS.COFINSOutr.vAliqProd = ""
  @dataSet.det.imposto.COFINS.COFINSOutr.vCOFINS = ""

  # COFINSST
  @dataSet.det.imposto.COFINSST.vBC = ""
  @dataSet.det.imposto.COFINSST.pCOFINS = ""
  @dataSet.det.imposto.COFINSST.qBCProd = ""
  @dataSet.det.imposto.COFINSST.vAliqProd = ""
  @dataSet.det.imposto.COFINSST.vCOFINS = ""

  # ISSQN
  @dataSet.det.imposto.ISSQN.vBC = ""
  @dataSet.det.imposto.ISSQN.vAliq = ""
  @dataSet.det.imposto.ISSQN.vISSQN = ""
  @dataSet.det.imposto.ISSQN.cMunFG = ""
  @dataSet.det.imposto.ISSQN.cListServ = ""
  @dataSet.det.imposto.ISSQN.vDeducao = ""
  @dataSet.det.imposto.ISSQN.vOutro = ""
  @dataSet.det.imposto.ISSQN.vDescIncond = ""
  @dataSet.det.imposto.ISSQN.vDescCond = ""
  @dataSet.det.imposto.ISSQN.vISSRet = ""
  @dataSet.det.imposto.ISSQN.indISS = ""
  @dataSet.det.imposto.ISSQN.cServico = ""
  @dataSet.det.imposto.ISSQN.cMun = ""
  @dataSet.det.imposto.ISSQN.cPais = ""
  @dataSet.det.imposto.ISSQN.nProcesso = ""
  @dataSet.det.imposto.ISSQN.indIncentivo = ""

  # Informação do imposto devolvido
  @dataSet.det.impostoDevol.pDevol = ""
  @dataSet.det.impostoDevol.IPI.vIPIDevol = ""

  # Informações adicionais do produto
  @dataSet.det.infAdProd = ""
@dataSet.salvarParte("DET")

# Total ICMS
@dataSet.total.ICMSTot.vBC = ""
@dataSet.total.ICMSTot.vICMS = ""
@dataSet.total.ICMSTot.vICMSDeson = ""
@dataSet.total.ICMSTot.vFCPUFDest = ""
@dataSet.total.ICMSTot.vICMSUFDest = ""
@dataSet.total.ICMSTot.vICMSUFRemet = ""
@dataSet.total.ICMSTot.vFCP = ""
@dataSet.total.ICMSTot.vBCST = ""
@dataSet.total.ICMSTot.vST = ""
@dataSet.total.ICMSTot.vFCPST = ""
@dataSet.total.ICMSTot.vFCPSTRet = ""
@dataSet.total.ICMSTot.vProd = ""
@dataSet.total.ICMSTot.vFrete = ""
@dataSet.total.ICMSTot.vSeg = ""
@dataSet.total.ICMSTot.vDesc = ""
@dataSet.total.ICMSTot.vII = ""
@dataSet.total.ICMSTot.vIPI = ""
@dataSet.total.ICMSTot.vIPIDevol = ""
@dataSet.total.ICMSTot.vPIS = ""
@dataSet.total.ICMSTot.vCOFINS = ""
@dataSet.total.ICMSTot.vOutro = ""
@dataSet.total.ICMSTot.vNF = ""
@dataSet.total.ICMSTot.vTotTrib = ""

# Total ISSQN
@dataSet.total.ISSQNtot.vServ = ""
@dataSet.total.ISSQNtot.vBC = ""
@dataSet.total.ISSQNtot.vISS = ""
@dataSet.total.ISSQNtot.vPIS = ""
@dataSet.total.ISSQNtot.vCOFINS = ""
@dataSet.total.ISSQNtot.dCompet = ""
@dataSet.total.ISSQNtot.vDeducao = ""
@dataSet.total.ISSQNtot.vOutro = ""
@dataSet.total.ISSQNtot.vDescIncond = ""
@dataSet.total.ISSQNtot.vDescCond = ""
@dataSet.total.ISSQNtot.vISSRet = ""
@dataSet.total.ISSQNtot.cRegTrib = ""

# Retenções de tributos
@dataSet.total.retTrib.vRetPIS = ""
@dataSet.total.retTrib.vRetCOFINS = ""
@dataSet.total.retTrib.vRetCSLL = ""
@dataSet.total.retTrib.vBCIRRF = ""
@dataSet.total.retTrib.vIRRF = ""
@dataSet.total.retTrib.vBCRetPrev = ""
@dataSet.total.retTrib.vRetPrev = ""

# Transportadora
@dataSet.transp.modFrete = ""
@dataSet.transp.vagao = ""
@dataSet.transp.balsa = ""
@dataSet.transp.transporta.CNPJ = ""
@dataSet.transp.transporta.CPF = ""
@dataSet.transp.transporta.xNome = ""
@dataSet.transp.transporta.IE = ""
@dataSet.transp.transporta.xEnder = ""
@dataSet.transp.transporta.xMun = ""
@dataSet.transp.transporta.UF = ""
@dataSet.transp.retTransp.vServ = ""
@dataSet.transp.retTransp.vBCRet = ""
@dataSet.transp.retTransp.pICMSRet = ""
@dataSet.transp.retTransp.vICMSRet = ""
@dataSet.transp.retTransp.CFOP = ""
@dataSet.transp.retTransp.cMunFG = ""
@dataSet.transp.veicTransp.placa = ""
@dataSet.transp.veicTransp.UF = ""
@dataSet.transp.veicTransp.RNTC = ""

# Reboque
@dataSet.incluirParte("REBOQUE")
  @dataSet.reboque.placa = ""
  @dataSet.reboque.UF = ""
  @dataSet.reboque.RNTC = ""
@dataSet.salvarParte("REBOQUE")

# Volume
@dataSet.incluirParte("VOL")
  @dataSet.vol.qVol = ""
  @dataSet.vol.esp = ""
  @dataSet.vol.marca = ""
  @dataSet.vol.nVol = ""
  @dataSet.vol.pesoL = ""
  @dataSet.vol.pesoB = ""
  @dataSet.incluirParte("LACRES")
  @dataSet.lacres.nLacre = ""
  @dataSet.salvarParte("LACRES")
@dataSet.salvarParte("VOL")

# Cobrança
@dataSet.cobr.fat.nFat = ""
@dataSet.cobr.fat.vOrig = ""
@dataSet.cobr.fat.vDesc = ""
@dataSet.cobr.fat.vLiq = ""

# Duplicatas
@dataSet.incluirParte("DUP")
  @dataSet.dup.nDup = ""
  @dataSet.dup.dVenc = ""
  @dataSet.dup.vDup = ""
@dataSet.salvarParte("DUP")

# Pagamentos
@dataSet.incluirParte("DETPAG")
  @dataSet.detPag.indPag = ""
  @dataSet.detPag.tPag = ""
  @dataSet.detPag.vPag = ""
  @dataSet.detPag.card.tpIntegra = ""
  @dataSet.detPag.card.CNPJ = ""
  @dataSet.detPag.card.tBand = ""
  @dataSet.detPag.card.cAut = ""
  @dataSet.detPag.vTroco = ""
@dataSet.salvarParte("DETPAG")

# Informações do intermediador
@dataSet.infIntermed.CNPJ = ""
@dataSet.infIntermed.idCadIntTran = ""

# Informações adicionais
@dataSet.infAdic.infAdFisco = ""
@dataSet.infAdic.infCpl = ""

# Grupo campo de uso livre do contribuinte
@dataSet.incluirParte("OBSCONT")
  @dataSet.obsCont.xCampo = ""
  @dataSet.obsCont.xTexto = ""
@dataSet.salvarParte("OBSCONT")

# Grupo campo de uso livre do fisco
@dataSet.incluirParte("OBSFISCO")
  @dataSet.obsFisco.xCampo = ""
  @dataSet.obsFisco.xTexto = ""
@dataSet.salvarParte("OBSFISCO")

# Grupo processo referenciado
@dataSet.incluirParte("PROCREF")
  @dataSet.procRef.nProc = ""
  @dataSet.procRef.indProc = ""
@dataSet.salvarParte("PROCREF")

# Exportação
@dataSet.exporta.UFSaidaPais = ""
@dataSet.exporta.xLocExporta = ""
@dataSet.exporta.xLocDespacho = ""

# Compra
@dataSet.compra.xNEmp = ""
@dataSet.compra.xPed = ""
@dataSet.compra.xCont = ""

# Cana
@dataSet.cana.safra = ""
@dataSet.cana.ref = ""
@dataSet.cana.qTotMes = ""
@dataSet.cana.qTotAnt = ""
@dataSet.cana.qTotGer = ""
@dataSet.cana.deduc = ""
@dataSet.cana.vFor = ""
@dataSet.cana.vTotDed = ""
@dataSet.cana.vLiqFor = ""

# Fornecimento diário de cana
@dataSet.incluirParte("FORDIA")
  @dataSet.forDia.dia = ""
  @dataSet.forDia.qtde = ""
@dataSet.salvarParte("FORDIA")

# Fornecimento diário de cana
@dataSet.incluirParte("DEDUC")
  @dataSet.deduc.xDed = ""
  @dataSet.deduc.vDed = ""
@dataSet.salvarParte("DEDUC")

# Informações do responsável técnico
@dataSet.infRespTec.CNPJ = ""
@dataSet.infRespTec.xContato = ""
@dataSet.infRespTec.email = ""
@dataSet.infRespTec.fone = ""
@dataSet.infRespTec.idCSRT = ""
@dataSet.infRespTec.hashCSRT = ""

# Informações suplementares
@dataSet.infNFeSupl.qrCode = ""
@dataSet.infNFeSupl.urlChave = ""

# Gerando o XML e HASH do DataSet
@xml, @hash = @dataSet.gerarNF
```
