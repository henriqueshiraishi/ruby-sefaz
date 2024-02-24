# frozen_string_literal: true

require "test_helper"

class SEFAZ::Webservice::SAT::Dataset::TestSale < Minitest::Test

  def test_is_the_dataset_is_working
    dataset = SEFAZ::Webservice::SAT::Dataset::Sale.new

    dataset.ide.CNPJ = "XXX.XXX.XXX/XXXX-XX"
    dataset.emit.CNPJ = "YYY.YYY.YYY/YYYY-YY"
    dataset.emit.IE = "01234567890123456789"
    dataset.dest.CNPJ = "ZZZ.ZZZ.ZZZ/ZZZZ-ZZ"
    dataset.dest.CPF = "ZZZ.ZZZ.ZZZ-ZZ"
    dataset.dest.xNome = "SHIRAISHI ASSESSORIA INFORMATICA LTDA"

    dataset.add("DET") do |det|
      det.prod.cProd = "1234"
      det.prod.cEAN = "999999999999"

      dataset.add("OBSFISCODET") do |obsfiscodet|
        obsfiscodet.xCampoDet = "XX"
        obsfiscodet.xTextoDet = "XX"
      end

      dataset.add("OBSFISCODET") do |obsfiscodet|
        obsfiscodet.xCampoDet = "ZZ"
        obsfiscodet.xTextoDet = "ZZ"
      end
    end

    dataset.add("MP") do |mp|
      mp.cMP = "07"
      mp.vMP = "200,00"
    end

    dataset.infAdic.infCpl = "Lorem ipsum dolor, sit amet consectetur adipisicing elit. Harum repudiandae numquam doloribus dolore ullam modi itaque cum omnis ducimus aspernatur hic voluptatum impedit, doloremque placeat possimus maxime ratione inventore. Unde!"
    xml, hash = dataset.gerarCF

    assert_equal xml, '<CFe><infCFe versaoDadosEnt="0.08"><ide><CNPJ>XXX.XXX.XXX/XXXX-XX</CNPJ></ide><emit><CNPJ>YYY.YYY.YYY/YYYY-YY</CNPJ><IE>01234567890123456789</IE></emit><dest><CNPJ>ZZZ.ZZZ.ZZZ/ZZZZ-ZZ</CNPJ><CPF>ZZZ.ZZZ.ZZZ-ZZ</CPF><xNome>SHIRAISHI ASSESSORIA INFORMATICA LTDA</xNome></dest><det nItem="1"><prod><cProd>1234</cProd><cEAN>999999999999</cEAN><obsFiscoDet><xCampoDet>XX</xCampoDet><xTextoDet>XX</xTextoDet></obsFiscoDet><obsFiscoDet><xCampoDet>ZZ</xCampoDet><xTextoDet>ZZ</xTextoDet></obsFiscoDet></prod></det><pgto><MP><cMP>07</cMP><vMP>200,00</vMP></MP></pgto><infAdic><infCpl>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Harum repudiandae numquam doloribus dolore ullam modi itaque cum omnis ducimus aspernatur hic voluptatum impedit, doloremque placeat possimus maxime ratione inventore. Unde!</infCpl></infAdic></infCFe></CFe>'
    assert_equal hash[:CFe][:infCFe][:ide][:CNPJ], "XXX.XXX.XXX/XXXX-XX"
    assert_equal hash[:CFe][:infCFe][:emit][:CNPJ], "YYY.YYY.YYY/YYYY-YY"
    assert_equal hash[:CFe][:infCFe][:emit][:IE], "01234567890123456789"
    assert_equal hash[:CFe][:infCFe][:dest][:CNPJ], "ZZZ.ZZZ.ZZZ/ZZZZ-ZZ"
    assert_equal hash[:CFe][:infCFe][:dest][:CPF], "ZZZ.ZZZ.ZZZ-ZZ"
    assert_equal hash[:CFe][:infCFe][:dest][:xNome], "SHIRAISHI ASSESSORIA INFORMATICA LTDA"
    assert_equal hash[:CFe][:infCFe][:det][:@nItem], "1"
    assert_equal hash[:CFe][:infCFe][:det][:prod][:cProd], "1234"
    assert_equal hash[:CFe][:infCFe][:det][:prod][:cEAN], "999999999999"
    assert_equal hash[:CFe][:infCFe][:det][:prod][:obsFiscoDet].class, Array
    assert_equal hash[:CFe][:infCFe][:det][:prod][:obsFiscoDet].length, 2
    assert_equal hash[:CFe][:infCFe][:det][:prod][:obsFiscoDet].first[:xCampoDet], 'XX'
    assert_equal hash[:CFe][:infCFe][:det][:prod][:obsFiscoDet].last[:xCampoDet], 'ZZ'
    assert_equal hash[:CFe][:infCFe][:pgto][:MP][:cMP], "07"
    assert_equal hash[:CFe][:infCFe][:pgto][:MP][:vMP], "200,00"
    assert_equal hash[:CFe][:infCFe][:infAdic][:infCpl], "Lorem ipsum dolor, sit amet consectetur adipisicing elit. Harum repudiandae numquam doloribus dolore ullam modi itaque cum omnis ducimus aspernatur hic voluptatum impedit, doloremque placeat possimus maxime ratione inventore. Unde!"
  end

  def test_if_field_can_be_set
    dataset = SEFAZ::Webservice::SAT::Dataset::Sale.new
    dataset.ide.CNPJ = ""
    dataset.ide.signAC = ""
    dataset.ide.numeroCaixa = ""
    dataset.emit.CNPJ = ""
    dataset.emit.IE = ""
    dataset.emit.IM = ""
    dataset.emit.cRegTribISSQN = ""
    dataset.emit.indRatISSQN = ""
    dataset.dest.CNPJ = ""
    dataset.dest.CPF = ""
    dataset.dest.xNome = ""
    dataset.entrega.xLgr = ""
    dataset.entrega.nro = ""
    dataset.entrega.xCpl = ""
    dataset.entrega.xBairro = ""
    dataset.entrega.xMun = ""
    dataset.entrega.UF = ""
    dataset.add("DET") do |det|
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
      dataset.add("OBSFISCODET") do |obsfiscodet|
        obsfiscodet.xCampoDet = ""
        obsfiscodet.xTextoDet = ""
      end
      det.imposto.vItem12741 = ""
      det.imposto.ICMS.ICMS00.Orig = ""
      det.imposto.ICMS.ICMS00.CST = ""
      det.imposto.ICMS.ICMS00.pICMS = ""
      det.imposto.ICMS.ICMS40.Orig = ""
      det.imposto.ICMS.ICMS40.CST = ""
      det.imposto.ICMS.ICMSSN102.Orig = ""
      det.imposto.ICMS.ICMSSN102.CSOSN = ""
      det.imposto.ICMS.ICMSSN900.Orig = ""
      det.imposto.ICMS.ICMSSN900.CSOSN = ""
      det.imposto.ICMS.ICMSSN900.pICMS = ""
      det.imposto.PIS.PISAliq.CST = ""
      det.imposto.PIS.PISAliq.vBC = ""
      det.imposto.PIS.PISAliq.pPIS = ""
      det.imposto.PIS.PISQtde.CST = ""
      det.imposto.PIS.PISQtde.qBCProd = ""
      det.imposto.PIS.PISQtde.vAliqProd = ""
      det.imposto.PIS.PISNT.CST = ""
      det.imposto.PIS.PISSN.CST = ""
      det.imposto.PIS.PISOutr.CST = ""
      det.imposto.PIS.PISOutr.vBC = ""
      det.imposto.PIS.PISOutr.pPIS = ""
      det.imposto.PIS.PISOutr.qBCProd = ""
      det.imposto.PIS.PISOutr.vAliqProd = ""
      det.imposto.PISST.vBC = ""
      det.imposto.PISST.pPIS = ""
      det.imposto.PISST.qBCProd = ""
      det.imposto.PISST.vAliqProd = ""
      det.imposto.COFINS.COFINSAliq.CST = ""
      det.imposto.COFINS.COFINSAliq.vBC = ""
      det.imposto.COFINS.COFINSAliq.pCOFINS = ""
      det.imposto.COFINS.COFINSQtde.CST = ""
      det.imposto.COFINS.COFINSQtde.qBCProd = ""
      det.imposto.COFINS.COFINSQtde.vAliqProd = ""
      det.imposto.COFINS.COFINSNT.CST = ""
      det.imposto.COFINS.COFINSSN.CST = ""
      det.imposto.COFINS.COFINSOutr.CST = ""
      det.imposto.COFINS.COFINSOutr.vBC = ""
      det.imposto.COFINS.COFINSOutr.pCOFINS = ""
      det.imposto.COFINS.COFINSOutr.qBCProd = ""
      det.imposto.COFINS.COFINSOutr.vAliqProd = ""
      det.imposto.COFINSST.vBC = ""
      det.imposto.COFINSST.pCOFINS = ""
      det.imposto.COFINSST.qBCProd = ""
      det.imposto.COFINSST.vAliqProd = ""
      det.imposto.ISSQN.vDeducISSQN = ""
      det.imposto.ISSQN.vAliq = ""
      det.imposto.ISSQN.cMunFG = ""
      det.imposto.ISSQN.cListServ = ""
      det.imposto.ISSQN.cServTribMun = ""
      det.imposto.ISSQN.cNatOp = ""
      det.imposto.ISSQN.indIncFisc = ""
      det.infAdProd = ""
    end
    dataset.total.vCFeLei12741 = ""
    dataset.total.DescAcrEntr.vDescSubtot = ""
    dataset.total.DescAcrEntr.vAcresSubtot = ""
    dataset.add("MP") do |mp|
      mp.cMP = ""
      mp.vMP = ""
      mp.cAdmC = ""
      mp.cAut = ""
    end
    dataset.infAdic.infCpl = ""
    xml, hash = dataset.gerarCF

    assert_equal xml, ""
    assert_equal hash, {}
  end

end
