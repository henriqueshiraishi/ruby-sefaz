# frozen_string_literal: true

module SEFAZ
  module Webservice
    module NFE
      # Principal classe de elaboração do XML para o módulo NF-e/NFC-e
      class Dataset

        attr_accessor :ide, :NFref, :emit, :avulsa, :dest, :retirada, :entrega, :autXML, :det, :DI, :adi, :detExport, :rastro, :arma, :total, :transp, :reboque, :vol, :lacres, :cobr, :dup, :detPag, :infIntermed, :infAdic, :obscont, :obsfisco, :procref, :exporta, :compra, :cana, :forDia, :deduc, :infRespTec, :infNFeSupl
  
        IDE           = Struct.new(:cUF, :cNF, :natOp, :mod, :serie, :nNF, :dhEmi, :dhSaiEnt, :tpNF, :idDest, :cMunFG, :tpImp, :tpEmis, :cDV, :tpAmb, :finNFe, :indFinal, :indPres, :indIntermed, :procEmi, :verProc, :dhCont, :xJust, :NFref)
        NFREF         = Struct.new(:refNFe, :cUF, :AAMM, :CNPJ, :CPF, :IE, :mod, :serie, :nNF, :refCTe, :nECF, :nCOO)
        EMIT          = Struct.new(:CNPJ, :CPF, :xNome, :xFant, :enderEmit, :IE, :IEST, :IM, :CNAE, :CRT)
        ENDEREMIT     = Struct.new(:xLgr, :nro, :xCpl, :xBairro, :cMun, :xMun, :UF, :CEP, :cPais, :xPais, :fone)
        AVULSA        = Struct.new(:CNPJ, :xOrgao, :matr, :xAgente, :fone, :UF, :nDAR, :dEmi, :vDAR, :repEmi, :dPag)
        DEST          = Struct.new(:CNPJ, :CPF, :idEstrangeiro, :xNome, :enderDest, :indIEDest, :IE, :ISUF, :IM, :email)
        ENDERDEST     = Struct.new(:xLgr, :nro, :xCpl, :xBairro, :cMun, :xMun, :UF, :CEP, :cPais, :xPais, :fone)
        RETIRADA      = Struct.new(:CNPJ, :CPF, :xNome, :xLgr, :nro, :xCpl, :xBairro, :cMun, :xMun, :UF, :CEP, :cPais, :xPais, :fone, :email, :IE)
        ENTREGA       = Struct.new(:CNPJ, :CPF, :xNome, :xLgr, :nro, :xCpl, :xBairro, :cMun, :xMun, :UF, :CEP, :cPais, :xPais, :fone, :email, :IE)
        AUTXML        = Struct.new(:CNPJ, :CPF)
        DET           = Struct.new(:@nItem, :prod, :imposto, :impostoDevol, :infAdProd)
        PROD          = Struct.new(:cProd, :cEAN, :xProd, :NCM, :NVE, :CEST, :indEscala, :CNPJFab, :cBenef, :EXTIPI, :CFOP, :uCom, :qCom, :vUnCom, :vProd, :cEANTrib, :uTrib, :qTrib, :vUnTrib, :vFrete, :vSeg, :vDesc, :vOutro, :indTot, :DI, :detExport, :xPed, :nItemPed, :nFCI, :rastro, :veicProd, :med, :arma, :comb, :nRECOPI)
        DI            = Struct.new(:nDI, :dDI, :xLocDesemb, :UFDesemb, :dDesemb, :tpViaTransp, :vAFRMM, :tpIntermedio, :CNPJ, :UFTerceiro, :cExportador, :adi)
        ADI           = Struct.new(:nAdicao, :nSeqAdic, :cFabricante, :vDescDI, :nDraw)
        DETEXPORT     = Struct.new(:nDraw, :exportInd)
        EXPORTIND     = Struct.new(:nRE, :chNFe, :qExport)
        RASTRO        = Struct.new(:nLote, :qLote, :dFab, :dVal, :cAgreg)
        VEICPROD      = Struct.new(:tpOp, :chassi, :cCor, :xCor, :pot, :cilin, :pesoL, :pesoB, :nSerie, :tpComb, :nMotor, :CMT, :dist, :anoMod, :anoFab, :tpPint, :tpVeic, :espVeic, :VIN, :condVeic, :cMod, :cCorDENATRAN, :lota, :tpRest)
        MED           = Struct.new(:cProdANVISA, :xMotivoIsencao, :vPMC)
        ARMA          = Struct.new(:tpArma, :nSerie, :nCano, :descr)
        COMB          = Struct.new(:cProdANP, :descANP, :pGLP, :pGNn, :pGNi, :vPart, :CODIF, :qTemp, :UFCons, :CIDE, :encerrante)
        CIDE          = Struct.new(:qBCProd, :vAliqProd, :vCIDE)
        ENCERRANTE    = Struct.new(:nBico, :nBomba, :nTanque, :vEncIni, :vEncFin)
        IMPOSTO       = Struct.new(:vTotTrib, :ICMS, :ICMSUFDest, :IPI, :II, :PIS, :PISST, :COFINS, :COFINSST, :ISSQN)
        ICMS          = Struct.new(:ICMS00, :ICMS10, :ICMS20, :ICMS30, :ICMS40, :ICMS51, :ICMS60, :ICMS70, :ICMS90, :ICMSPart, :ICMSST, :ICMSSN101, :ICMSSN102, :ICMSSN201, :ICMSSN202, :ICMSSN500, :ICMSSN900)
        ICMS00        = Struct.new(:orig, :CST, :modBC, :vBC, :pICMS, :vICMS, :pFCP, :vFCP)
        ICMS10        = Struct.new(:orig, :CST, :modBC, :vBC, :pICMS, :vICMS, :vBCFCP, :pFCP, :vFCP, :modBCST, :pMVAST, :pRedBCST, :vBCST, :pICMSST, :vICMSST, :vBCFCPST, :pFCPST, :vFCPST)
        ICMS20        = Struct.new(:orig, :CST, :modBC, :pRedBC, :vBC, :pICMS, :vICMS, :vBCFCP, :pFCP, :vFCP, :vICMSDeson, :motDesICMS)
        ICMS30        = Struct.new(:orig, :CST, :modBCST, :pMVAST, :pRedBCST, :vBCST, :pICMSST, :vICMSST, :vBCFCPST, :pFCPST, :vFCPST, :vICMSDeson, :motDesICMS)
        ICMS40        = Struct.new(:orig, :CST, :vICMSDeson, :motDesICMS)
        ICMS51        = Struct.new(:orig, :CST, :modBC, :pRedBC, :vBC, :pICMS, :vICMSOp, :pDif, :vICMSDif, :vICMS, :vBCFCP, :pFCP, :vFCP)
        ICMS60        = Struct.new(:orig, :CST, :vBCSTRet, :pST, :vICMSSubstituto, :vICMSSTRet, :vBCFCPSTRet, :pFCPSTRet, :vFCPSTRet, :pRedBCEfet, :vBCEfet, :pICMSEfet, :vICMSEfet)
        ICMS70        = Struct.new(:orig, :CST, :modBC, :pRedBC, :vBC, :pICMS, :vICMS, :vBCFCP, :pFCP, :vFCP, :modBCST, :pMVAST, :pRedBCST, :vBCST, :pICMSST, :vICMSST, :vBCFCPST, :pFCPST, :vFCPST, :vICMSDeson, :motDesICMS)
        ICMS90        = Struct.new(:orig, :CST, :modBC, :vBC, :pRedBC, :pICMS, :vICMS, :vBCFCP, :pFCP, :vFCP, :modBCST, :pMVAST, :pRedBCST, :vBCST, :pICMSST, :vICMSST, :vBCFCPST, :pFCPST, :vFCPST, :vICMSDeson, :motDesICMS)
        ICMSPart      = Struct.new(:orig, :CST, :modBC, :vBC, :pRedBC, :pICMS, :vICMS, :modBCST, :pMVAST, :pRedBCST, :vBCST, :pICMSST, :vICMSST, :pBCOp, :UFST)
        ICMSST        = Struct.new(:orig, :CST, :vBCSTRet, :pST, :vICMSSubstituto, :vICMSSTRet, :vBCFCPSTRet, :pFCPSTRet, :vFCPSTRet, :vBCSTDest, :vICMSSTDest, :pRedBCEfet, :vBCEfet, :pICMSEfet, :vICMSEfet)
        ICMSSN101     = Struct.new(:orig, :CSOSN, :pCredSN, :vCredICMSSN)
        ICMSSN102     = Struct.new(:orig, :CSOSN)
        ICMSSN201     = Struct.new(:orig, :CSOSN, :modBCST, :pMVAST, :pRedBCST, :vBCST, :pICMSST, :vICMSST, :vBCFCPST, :pFCPST, :vFCPST, :pCredSN, :vCredICMSSN)
        ICMSSN202     = Struct.new(:orig, :CSOSN, :modBCST, :pMVAST, :pRedBCST, :vBCST, :pICMSST, :vICMSST, :vBCFCPST, :pFCPST, :vFCPST)
        ICMSSN500     = Struct.new(:orig, :CSOSN, :vBCSTRet, :pST, :vICMSSubstituto, :vICMSSTRet, :vBCFCPSTRet, :pFCPSTRet, :vFCPSTRet, :pRedBCEfet, :vBCEfet, :pICMSEfet, :vICMSEfet)
        ICMSSN900     = Struct.new(:orig, :CSOSN, :modBC, :vBC, :pRedBC, :pICMS, :vICMS, :modBCST, :pMVAST, :pRedBCST, :vBCST, :pICMSST, :vICMSST, :vBCFCPST, :pFCPST, :vFCPST, :pCredSN, :vCredICMSSN)
        ICMSUFDest    = Struct.new(:vBCUFDest, :vBCFCPUFDest, :pFCPUFDest, :pICMSUFDest, :pICMSInter, :pICMSInterPart, :vFCPUFDest, :vICMSUFDest, :vICMSUFRemet)
        IPI           = Struct.new(:CNPJProd, :cSelo, :qSelo, :cEnq, :IPITrib, :IPINT)
        IPITrib       = Struct.new(:CST, :vBC, :qUnid, :vUnid, :vIPI)
        IPINT         = Struct.new(:CST)
        II            = Struct.new(:vBC, :vDespAdu, :vII, :vIOF)
        PIS           = Struct.new(:PISAliq, :PISQtde, :PISNT, :PISOutr)
        PISAliq       = Struct.new(:CST, :vBC, :pPIS, :vPIS)
        PISQtde       = Struct.new(:CST, :qBCProd, :vAliqProd, :vPIS)
        PISNT         = Struct.new(:CST)
        PISOutr       = Struct.new(:CST, :vBC, :pPIS, :qBCProd, :vAliqProd, :vPIS)
        PISST         = Struct.new(:vBC, :pPIS, :qBCProd, :vAliqProd, :vPIS)
        COFINS        = Struct.new(:COFINSAliq, :COFINSQtde, :COFINSNT, :COFINSOutr)
        COFINSAliq    = Struct.new(:CST, :vBC, :pCOFINS, :vCOFINS)
        COFINSQtde    = Struct.new(:CST, :qBCProd, :vAliqProd, :vCOFINS)
        COFINSNT      = Struct.new(:CST)
        COFINSOutr    = Struct.new(:CST, :vBC, :pCOFINS, :qBCProd, :vAliqProd, :vCOFINS)
        COFINSST      = Struct.new(:vBC, :pCOFINS, :qBCProd, :vAliqProd, :vCOFINS)
        ISSQN         = Struct.new(:vBC, :vAliq, :vISSQN, :cMunFG, :cListServ, :vDeducao, :vOutro, :vDescIncond, :vDescCond, :vISSRet, :indISS, :cServico, :cMun, :cPais, :nProcesso, :indIncentivo)
        IMPOSTODEVOL  = Struct.new(:pDevol, :IPI)
        IPIDEVOL      = Struct.new(:vIPIDevol)
        TOTAL         = Struct.new(:ICMSTot, :ISSQNtot, :retTrib)
        ICMSTot       = Struct.new(:vBC, :vICMS, :vICMSDeson, :vFCPUFDest, :vICMSUFDest, :vICMSUFRemet, :vFCP, :vBCST, :vST, :vFCPST, :vFCPSTRet, :vProd, :vFrete, :vSeg, :vDesc, :vII, :vIPI, :vIPIDevol, :vPIS, :vCOFINS, :vOutro, :vNF, :vTotTrib)
        ISSQNtot      = Struct.new(:vServ, :vBC, :vISS, :vPIS, :vCOFINS, :dCompet, :vDeducao, :vOutro, :vDescIncond, :vDescCond, :vISSRet, :cRegTrib)
        RETTrib       = Struct.new(:vRetPIS, :vRetCOFINS, :vRetCSLL, :vBCIRRF, :vIRRF, :vBCRetPrev, :vRetPrev)
        TRANSP        = Struct.new(:modFrete, :transporta, :retTransp, :veicTransp, :reboque, :vagao, :balsa, :vol)
        TRANSPORTA    = Struct.new(:CNPJ, :CPF, :xNome, :IE, :xEnder, :xMun, :UF)
        RETTRANSP     = Struct.new(:vServ, :vBCRet, :pICMSRet, :vICMSRet, :CFOP, :cMunFG)
        VEICTRANSP    = Struct.new(:placa, :UF, :RNTC)
        REBOQUE       = Struct.new(:placa, :UF, :RNTC)
        VOL           = Struct.new(:qVol, :esp, :marca, :nVol, :pesoL, :pesoB, :lacres)
        LACRES        = Struct.new(:nLacre)
        COBR          = Struct.new(:fat, :dup)
        FAT           = Struct.new(:nFat, :vOrig, :vDesc, :vLiq)
        DUP           = Struct.new(:nDup, :dVenc, :vDup)
        PAG           = Struct.new(:detPag)
        DETPAG        = Struct.new(:indPag, :tPag, :vPag, :card, :vTroco)
        CARD          = Struct.new(:tpIntegra, :CNPJ, :tBand, :cAut)
        INFINTERMED   = Struct.new(:CNPJ, :idCadIntTran)
        INFADIC       = Struct.new(:infAdFisco, :infCpl, :obsCont, :obsFisco, :procRef)
        OBSCONT       = Struct.new(:xCampo, :xTexto)
        OBSFISCO      = Struct.new(:xCampo, :xTexto)
        PROCREF       = Struct.new(:nProc, :indProc)
        EXPORTA       = Struct.new(:UFSaidaPais, :xLocExporta, :xLocDespacho)
        COMPRA        = Struct.new(:xNEmp, :xPed, :xCont)
        CANA          = Struct.new(:safra, :ref, :forDia, :qTotMes, :qTotAnt, :qTotGer, :deduc, :vFor, :vTotDed, :vLiqFor)
        FORDIA        = Struct.new(:dia, :qtde)
        DEDUC         = Struct.new(:xDed, :vDed)
        INFRESPTEC    = Struct.new(:CNPJ, :xContato, :email, :fone, :idCSRT, :hashCSRT)
        INFNFESUPL    = Struct.new(:qrCode, :urlChave)
  
        def initialize(chaveNF)
          @versao   = "4.00"
          @chaveNF  = chaveNF
  
          @ide                = IDE.new
          @ide.NFref          = []
          @emit               = EMIT.new
          @emit.enderEmit     = ENDEREMIT.new
          @avulsa             = AVULSA.new
          @dest               = DEST.new
          @dest.enderDest     = ENDERDEST.new
          @retirada           = RETIRADA.new
          @entrega            = ENTREGA.new
          @total              = TOTAL.new
          @total.ICMSTot      = ICMSTot.new
          @total.ISSQNtot     = ISSQNtot.new
          @total.retTrib      = RETTrib.new
          @transp             = TRANSP.new
          @transp.transporta  = TRANSPORTA.new
          @transp.retTransp   = RETTRANSP.new
          @transp.veicTransp  = VEICTRANSP.new
          @transp.reboque     = []
          @transp.vol         = []
          @cobr               = COBR.new
          @cobr.fat           = FAT.new
          @cobr.dup           = []
          @pag                = PAG.new
          @pag.detPag         = []
          @infIntermed        = INFINTERMED.new
          @infAdic            = INFADIC.new
          @infAdic.obsCont    = []
          @infAdic.obsFisco   = []
          @infAdic.procRef    = []
          @exporta            = EXPORTA.new
          @compra             = COMPRA.new
          @cana               = CANA.new
          @cana.forDia        = []
          @cana.deduc         = []
          @infRespTec         = INFRESPTEC.new
          @infNFeSupl         = INFNFESUPL.new
  
          @listas = {}
          @listas[:autXML] = []
          @listas[:det]    = []
        end
  
        def gerarNF
          # Raiz = NFe
          # A01 = infNFe
          # H01 = det
          # I01 = prod
          # M01 = imposto
          # N01 = ICMS
          hash = { NFe: { :@xmlns => "http://www.portalfiscal.inf.br/nfe", infNFe: { :@Id => ("NFe" + @chaveNF.to_s), :@versao => @versao } } }
          hash[:NFe][:infNFe][:ide] = @ide.to_h
          hash[:NFe][:infNFe][:emit] = @emit.to_h
          hash[:NFe][:infNFe][:emit][:enderEmit] = @emit.enderEmit.to_h
          hash[:NFe][:infNFe][:avulsa] = @avulsa.to_h
          hash[:NFe][:infNFe][:dest] = @dest.to_h
          hash[:NFe][:infNFe][:dest][:enderDest] = @dest.enderDest.to_h
          hash[:NFe][:infNFe][:retirada] = @retirada.to_h
          hash[:NFe][:infNFe][:entrega] = @entrega.to_h
          hash[:NFe][:infNFe][:autXML] = @listas[:autXML]
          hash[:NFe][:infNFe][:det] = @listas[:det]
          hash[:NFe][:infNFe][:total] = @total.to_h
          hash[:NFe][:infNFe][:total][:ICMSTot] = @total.ICMSTot.to_h
          hash[:NFe][:infNFe][:total][:ISSQNtot] = @total.ISSQNtot.to_h
          hash[:NFe][:infNFe][:total][:retTrib] = @total.retTrib.to_h
          hash[:NFe][:infNFe][:transp] = @transp.to_h
          hash[:NFe][:infNFe][:transp][:transporta] = @transp.transporta.to_h
          hash[:NFe][:infNFe][:transp][:retTransp] = @transp.retTransp.to_h
          hash[:NFe][:infNFe][:transp][:veicTransp] = @transp.veicTransp.to_h
          hash[:NFe][:infNFe][:cobr] = @cobr.to_h
          hash[:NFe][:infNFe][:cobr][:fat] = @cobr.fat.to_h
          hash[:NFe][:infNFe][:pag] = @pag.to_h
          hash[:NFe][:infNFe][:infIntermed] = @infIntermed.to_h
          hash[:NFe][:infNFe][:infAdic] = @infAdic.to_h
          hash[:NFe][:infNFe][:exporta] = @exporta.to_h
          hash[:NFe][:infNFe][:compra] = @compra.to_h
          hash[:NFe][:infNFe][:cana] = @cana.to_h
          hash[:NFe][:infNFe][:infRespTec] = @infRespTec.to_h
          hash[:NFe][:infNFeSupl] = @infNFeSupl.to_h
          compressed = hash.compress!

          return [compressed.to_xml!, compressed]
        end
  
        def add(part_name)
          part_object = case part_name
          when "NFREF"
            @NFref = NFREF.new
            @NFref
          when "AUTXML"
            @autXML = AUTXML.new
            @autXML
          when "DET"
            @det = DET.new
            @det.prod = PROD.new
            @det.prod.veicProd = VEICPROD.new
            @det.prod.med = MED.new
            @det.prod.comb = COMB.new
            @det.prod.comb.CIDE = CIDE.new
            @det.prod.comb.encerrante = ENCERRANTE.new
            @det.prod.DI = []
            @det.prod.detExport = []
            @det.prod.rastro = []
            @det.prod.arma = []
            @det.imposto = IMPOSTO.new
            @det.imposto.ICMS = ICMS.new
            @det.imposto.ICMS.ICMS00 = ICMS00.new
            @det.imposto.ICMS.ICMS10 = ICMS10.new
            @det.imposto.ICMS.ICMS20 = ICMS20.new
            @det.imposto.ICMS.ICMS30 = ICMS30.new
            @det.imposto.ICMS.ICMS40 = ICMS40.new
            @det.imposto.ICMS.ICMS51 = ICMS51.new
            @det.imposto.ICMS.ICMS60 = ICMS60.new
            @det.imposto.ICMS.ICMS70 = ICMS70.new
            @det.imposto.ICMS.ICMS90 = ICMS90.new
            @det.imposto.ICMS.ICMSPart = ICMSPart.new
            @det.imposto.ICMS.ICMSST = ICMSST.new
            @det.imposto.ICMS.ICMSSN101 = ICMSSN101.new
            @det.imposto.ICMS.ICMSSN102 = ICMSSN102.new
            @det.imposto.ICMS.ICMSSN201 = ICMSSN201.new
            @det.imposto.ICMS.ICMSSN202 = ICMSSN202.new
            @det.imposto.ICMS.ICMSSN500 = ICMSSN500.new
            @det.imposto.ICMS.ICMSSN900 = ICMSSN900.new
            @det.imposto.ICMSUFDest = ICMSUFDest.new
            @det.imposto.IPI = IPI.new
            @det.imposto.IPI.IPITrib = IPITrib.new
            @det.imposto.IPI.IPINT = IPINT.new
            @det.imposto.II = II.new
            @det.imposto.PIS = PIS.new
            @det.imposto.PIS.PISAliq = PISAliq.new
            @det.imposto.PIS.PISQtde = PISQtde.new
            @det.imposto.PIS.PISNT = PISNT.new
            @det.imposto.PIS.PISOutr = PISOutr.new
            @det.imposto.PISST = PISST.new
            @det.imposto.COFINS = COFINS.new
            @det.imposto.COFINS.COFINSAliq = COFINSAliq.new
            @det.imposto.COFINS.COFINSQtde = COFINSQtde.new
            @det.imposto.COFINS.COFINSNT = COFINSNT.new
            @det.imposto.COFINS.COFINSOutr = COFINSOutr.new
            @det.imposto.COFINSST = COFINSST.new
            @det.imposto.ISSQN = ISSQN.new
            @det.impostoDevol = IMPOSTODEVOL.new
            @det.impostoDevol.IPI = IPIDEVOL.new
            @det
          when "DI"
            @DI = DI.new
            @DI.adi = []
            @DI
          when "ADI"
            @adi = ADI.new
            @adi
          when "DETEXPORT"
            @detExport = DETEXPORT.new
            @detExport.exportInd = EXPORTIND.new
            @detExport
          when "RASTRO"
            @rastro = RASTRO.new
            @rastro
          when "ARMA"
            @arma = ARMA.new
            @arma
          when "REBOQUE"
            @reboque = REBOQUE.new
            @reboque
          when "VOL"
            @vol = VOL.new
            @vol.lacres = []
            @vol
          when "LACRES"
            @lacres = LACRES.new
            @lacres
          when "DUP"
            @dup = DUP.new
            @dup
          when "DETPAG"
            @detPag = DETPAG.new
            @detPag.card = CARD.new
            @detPag
          when "OBSCONT"
            @obscont = OBSCONT.new
            @obscont
          when "OBSFISCO"
            @obsfisco = OBSFISCO.new
            @obsfisco
          when "PROCREF"
            @procref = PROCREF.new
            @procref
          when "FORDIA"
            @forDia = FORDIA.new
            @forDia
          when "DEDUC"
            @deduc = DEDUC.new
            @deduc
          end

          if block_given?
            yield(part_object)
            save(part_name)
          end
  
          nil
        end
  
        def save(part_name)
          case part_name
          when "NFREF"
            if @ide.is_a?(Struct::IDE) && @NFref.is_a?(Struct::NFREF)
              case @NFref.mod
              when "01", "02"
                @ide.NFref.push({ refNF: { cUF: @NFref.cUF, AAMM: @NFref.AAMM, CNPJ: @NFref.CNPJ, mod: @NFref.mod, serie: @NFref.serie, nNF: @NFref.nNF } })
              when "04"
                @ide.NFref.push({ refNFP: { cUF: @NFref.cUF, AAMM: @NFref.AAMM, CNPJ: @NFref.CNPJ, CPF: @NFref.CPF, IE: @NFref.IE, mod: @NFref.mod, serie: @NFref.serie, nNF: @NFref.nNF, refCTe: @NFref.refCTe } })
              when "2B", "2C", "2D"
                @ide.NFref.push({ refECF: { mod: @NFref.mod, nECF: @NFref.nECF, nCOO: @NFref.nCOO } })
              else
                @ide.NFref.push({ refNFe: @NFref.refNFe })
              end
            end
          when "AUTXML"
            if @autXML.is_a?(Struct::AUTXML)
              @listas[:autXML].push(@autXML.to_h)
            end
          when "DET"
            if @det.is_a?(Struct::DET)
              item = @det
              item.prod.veicProd = item.prod.veicProd.to_h
              item.prod.med = item.prod.med.to_h
              item.prod.comb.encerrante = item.prod.comb.encerrante.to_h
              item.prod.comb.CIDE = item.prod.comb.CIDE.to_h
              item.prod.comb = item.prod.comb.to_h
              item.prod = item.prod.to_h
              item.imposto.ICMS.ICMS00 = item.imposto.ICMS.ICMS00.to_h
              item.imposto.ICMS.ICMS10 = item.imposto.ICMS.ICMS10.to_h
              item.imposto.ICMS.ICMS20 = item.imposto.ICMS.ICMS20.to_h
              item.imposto.ICMS.ICMS30 = item.imposto.ICMS.ICMS30.to_h
              item.imposto.ICMS.ICMS40 = item.imposto.ICMS.ICMS40.to_h
              item.imposto.ICMS.ICMS51 = item.imposto.ICMS.ICMS51.to_h
              item.imposto.ICMS.ICMS60 = item.imposto.ICMS.ICMS60.to_h
              item.imposto.ICMS.ICMS70 = item.imposto.ICMS.ICMS70.to_h
              item.imposto.ICMS.ICMS90 = item.imposto.ICMS.ICMS90.to_h
              item.imposto.ICMS.ICMSPart = item.imposto.ICMS.ICMSPart.to_h
              item.imposto.ICMS.ICMSST = item.imposto.ICMS.ICMSST.to_h
              item.imposto.ICMS.ICMSSN101 = item.imposto.ICMS.ICMSSN101.to_h
              item.imposto.ICMS.ICMSSN102 = item.imposto.ICMS.ICMSSN102.to_h
              item.imposto.ICMS.ICMSSN201 = item.imposto.ICMS.ICMSSN201.to_h
              item.imposto.ICMS.ICMSSN202 = item.imposto.ICMS.ICMSSN202.to_h
              item.imposto.ICMS.ICMSSN500 = item.imposto.ICMS.ICMSSN500.to_h
              item.imposto.ICMS.ICMSSN900 = item.imposto.ICMS.ICMSSN900.to_h
              item.imposto.ICMS = item.imposto.ICMS.to_h
              item.imposto.ICMSUFDest = item.imposto.ICMSUFDest.to_h
              item.imposto.IPI.IPITrib = item.imposto.IPI.IPITrib.to_h
              item.imposto.IPI.IPINT = item.imposto.IPI.IPINT.to_h
              item.imposto.IPI = item.imposto.IPI.to_h
              item.imposto.II = item.imposto.II.to_h
              item.imposto.PIS.PISAliq = item.imposto.PIS.PISAliq.to_h
              item.imposto.PIS.PISQtde = item.imposto.PIS.PISQtde.to_h
              item.imposto.PIS.PISNT = item.imposto.PIS.PISNT.to_h
              item.imposto.PIS.PISOutr = item.imposto.PIS.PISOutr.to_h
              item.imposto.PIS = item.imposto.PIS.to_h
              item.imposto.PISST = item.imposto.PISST.to_h
              item.imposto.COFINS.COFINSAliq = item.imposto.COFINS.COFINSAliq.to_h
              item.imposto.COFINS.COFINSQtde = item.imposto.COFINS.COFINSQtde.to_h
              item.imposto.COFINS.COFINSNT = item.imposto.COFINS.COFINSNT.to_h
              item.imposto.COFINS.COFINSOutr = item.imposto.COFINS.COFINSOutr.to_h
              item.imposto.COFINS = item.imposto.COFINS.to_h
              item.imposto.COFINSST = item.imposto.COFINSST.to_h
              item.imposto.ISSQN = item.imposto.ISSQN.to_h
              item.imposto = item.imposto.to_h
              item.impostoDevol.IPI = item.impostoDevol.IPI.to_h
              item.impostoDevol = item.impostoDevol.to_h
              item[:@nItem] = (@listas[:det].length + 1)
              @listas[:det].push(item.to_h)
            end
          when "DI"
            if @det.is_a?(Struct::DET) && @DI.is_a?(Struct::DI)
              @det.prod.DI.push(@DI.to_h)
            end
          when "ADI"
            if @DI.is_a?(Struct::DI) && @adi.is_a?(Struct::ADI)
              @DI.adi.push(@adi.to_h)
            end
          when "DETEXPORT"
            if @det.is_a?(Struct::DET) && @detExport.is_a?(Struct::DETEXPORT)
              item = @detExport
              item.exportInd = item.exportInd.to_h
              @det.prod.detExport.push(item.to_h)
            end
          when "RASTRO"
            if @det.is_a?(Struct::DET) && @rastro.is_a?(Struct::RASTRO)
              @det.prod.rastro.push(@rastro.to_h)
            end
          when "ARMA"
            if @det.is_a?(Struct::DET) && @arma.is_a?(Struct::ARMA)
              @det.prod.arma.push(@arma.to_h)
            end
          when "REBOQUE"
            if @transp.is_a?(Struct::TRANSP) && @reboque.is_a?(Struct::REBOQUE)
              @transp.reboque.push(@reboque.to_h)
            end
          when "VOL"
            if @transp.is_a?(Struct::TRANSP) && @vol.is_a?(Struct::VOL)
              @transp.vol.push(@vol.to_h)
            end
          when "LACRES"
            if @vol.is_a?(Struct::VOL) && @lacres.is_a?(Struct::LACRES)
              @vol.lacres.push(@lacres.to_h)
            end
          when "DUP"
            if @cobr.is_a?(Struct::COBR) && @dup.is_a?(Struct::DUP)
              @cobr.dup.push(@dup.to_h)
            end
          when "DETPAG"
            if @pag.is_a?(Struct::PAG) && @detPag.is_a?(Struct::DETPAG)
              item = @detPag
              item.card = item.card.to_h
              @pag.detPag.push(item.to_h)
            end
          when "OBSCONT"
            if @infAdic.is_a?(Struct::INFADIC) && @obscont.is_a?(Struct::OBSCONT)
              @infAdic.obsCont.push(@obscont.to_h)
            end
          when "OBSFISCO"
            if @infAdic.is_a?(Struct::INFADIC) && @obsfisco.is_a?(Struct::OBSFISCO)
              @infAdic.obsFisco.push(@obsfisco.to_h)
            end
          when "PROCREF"
            if @infAdic.is_a?(Struct::INFADIC) && @procref.is_a?(Struct::PROCREF)
              @infAdic.procRef.push(@procref.to_h)
            end
          when "FORDIA"
            if @cana.is_a?(Struct::CANA) && @forDia.is_a?(Struct::FORDIA)
              @cana.forDia.push(@forDia.to_h)
            end
          when "DEDUC"
            if @cana.is_a?(Struct::CANA) && @deduc.is_a?(Struct::DEDUC)
              @cana.deduc.push(@deduc.to_h)
            end
          end
  
          nil
        end
  
      end
    end
  end
end
