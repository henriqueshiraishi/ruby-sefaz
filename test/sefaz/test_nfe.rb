# frozen_string_literal: true

require "test_helper"

class TestNFE < Minitest::Test

  def setup
    @webService = SEFAZ::NFE.new
    @webService.setaAmbiente({ ambiente: "2", uf: "35" })
    @webService.setaRespTecnico({ cnpj: "00.000.000/0000-00", contato: "EMPRESA", email: "contato@empresa.com.br", fone: "+551100000000", idCSRT: "01", CSRT: "G8063VRTNDMO886SFNK5LDUDEI24XJ22YIPO" })
    @webService.setaPFXTss({ pfx: File.read("certificate.pfx"), senha: "1234" })
    @webService.setaPFXAss({ pfx: File.read("certificate.pfx"), senha: "1234" })
  end

  def test_if_the_gerarInfRespTec_is_working
    chaveNF = "41180678393592000146558900000006041028190697"
    xml, hash = @webService.gerarInfRespTec(chaveNF)
    refute_nil xml
    assert_equal hash[:infRespTec][:hashCSRT], "Njk2YmZhMmRlMTBjZTE3ZWFlZTNlYTgxMjM2Mzk4NjdjODJiOGEwYw=="
  end

  def test_if_the_statusDoServico_is_working
    xml, hash = @webService.statusDoServico
    refute_nil xml
    assert_equal hash[:nfeResultMsg][:retConsStatServ][:cStat], "107"
  end

  def test_is_the_consultarNF_is_working
    chaveNF = "35221221684155000164550010000002361125429343"
    xml, hash = @webService.consultarNF(chaveNF)
    refute_nil xml
    assert_equal hash[:nfeResultMsg][:retConsSitNFe][:cStat], "101"
  end

  def test_is_the_consultarCadastro_is_working
    nroDocumento = "01.014.625/0001-75"
    tpDocumento = "CNPJ"
    uf = "SP"
    xml, hash = @webService.consultarCadastro(nroDocumento, tpDocumento, uf)
    refute_nil xml
    assert_equal hash[:nfeResultMsg][:retConsCad][:infCons][:cStat], "259"
  end

  def test_is_the_consultarRecibo_is_working
    numRecibo = "351000171600547"
    xml, hash = @webService.consultarRecibo(numRecibo)
    refute_nil xml
    assert_equal hash[:nfeResultMsg][:retConsReciNFe][:cStat], "104"
  end

  def test_is_the_assinarNF_is_working
    xml_unsigned = '<NFe><infNFe Id="NFe35221221684155000164550010000002361125429343"></infNFe></NFe>'
    xml, hash = @webService.assinarNF(xml_unsigned)
    refute_nil xml
    assert_equal hash[:NFe][:Signature][:SignedInfo][:Reference][:@URI], ("#" + hash[:NFe][:infNFe][:@Id])
    assert_equal hash[:NFe][:Signature][:SignedInfo][:Reference][:DigestValue], "651Y4oR2GTkXoHb0xyQoX142Nfw="
    assert_equal hash[:NFe][:Signature][:SignatureValue], "wte8XAxftEUV1rc9vsWx/sXvBoMlkeAhug2E1KoacU56lrScQ0mfiyOeXXGwCzYNzJm5Up2yE1KBfpGqjndABMuJyuhFcX6YBf0BpCc3BXyCb4VCTbBsL62gD6QlVAaIwKtTKGYH7xqQkTxUw3PLsrGqNVJitjKBomX8L+ogJZUyuiRYTdH5EC+vlO2ci2GTZLXIF8zbWjDBxQdCpe6/X9vX/R27V8Hle02T1O1bpb9+eLCs3Tai1oY+YdixRRlUt40XBWZ9063PFMO9igARE2CRxtVtV6tI9e6kwVRqO+9ES+bItmZb1dKjuO7cTHdx8PR6WPq5R3dYtvtCcD3VvQ=="
  end

  def test_is_the_validarNF_is_working
    xml = File.read("docs/nfe-valida-autorizada.xml")
    stat, msg, err = @webService.validarNF(xml)
    assert_equal stat, true
    assert_equal msg.length, 3
    assert_equal err.length, 0
  end

  def test_is_the_auditarNF_is_working
    xml = File.read("docs/nfe-valida-autorizada.xml")
    stat, msg = @webService.auditarNF(xml)
    assert_equal stat, true
    assert_equal msg["notas"][0]["valido"], "XML Válido"
  end

  def test_is_the_gerarDANFE_is_working
    xml = File.read("docs/nfe-valida-autorizada.xml")
    stat, pdf = @webService.gerarDANFE(xml)
    assert_equal stat, true
    refute_nil pdf
  end

  def test_is_the_inutilizarNF_is_working
    chaveNF = ""
    ano = "23"
    cnpj = "21684155000164"
    modelo = "55"
    serie = "1"
    nroNFIni = "23"
    nroNFFin = "23"
    justificativa = "Teste de inutilização"
    xml, hash = @webService.inutilizarNF(chaveNF, ano, cnpj, modelo, serie, nroNFIni, nroNFFin, justificativa)
    refute_nil xml
    assert_equal hash[:nfeResultMsg][:retInutNFe][:infInut][:cStat], "563"
  end

  def test_is_the_calculaChaveInutilizacao_is_working
    ano = "23"
    cnpj = "01014625000175"
    modelo = "55"
    serie = "1"
    nroNFIni = "23"
    nroNFFin = "23"
    chaveNF = @webService.calculaChaveInutilizacao(ano, cnpj, modelo, serie, nroNFIni, nroNFFin)
    assert_equal chaveNF, "ID35230101462500017555001000000023000000023"
  end

  def test_if_the_exportarDadosInutilizarNF_is_working
    chaveNF = ""
    ano = "23"
    cnpj = "01014625000175"
    modelo = "55"
    serie = "1"
    nroNFIni = "23"
    nroNFFin = "23"
    justificativa = "Teste de inutilização"
    xml, hash = @webService.exportarDadosInutilizarNF(chaveNF, ano, cnpj, modelo, serie, nroNFIni, nroNFFin, justificativa)
    refute_nil xml
    assert_equal hash[:inutNFe][:infInut][:@Id], "ID35230101462500017555001000000023000000023"
  end

end
