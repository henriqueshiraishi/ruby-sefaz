# frozen_string_literal: true

require "test_helper"

class TestNFE < Minitest::Test

  def setup
    @webService = SEFAZ::NFE.new
    @webService.setaAmbiente({ ambiente: "2", uf: "35", cnpj: "21684155000164" })
    @webService.setaRespTecnico({ cnpj: "00.000.000/0000-00", contato: "EMPRESA", email: "contato@empresa.com.br", fone: "+551100000000", idCSRT: "01", CSRT: "G8063VRTNDMO886SFNK5LDUDEI24XJ22YIPO" })
    @webService.setaPFXTss({ pfx: File.read("certificateTransmission.pfx"), senha: "020607" })
    @webService.setaPFXAss({ pfx: File.read("certificateSignature.pfx"), senha: "1234" })
  end

  def test_if_the_gerarInfRespTec_is_working
    xml_unsigned = '<NFe><infNFe Id="NFe41180678393592000146558900000006041028190697"></infNFe></NFe>'
    xml, _ = @webService.assinarNF(xml_unsigned)
    xml, hash = @webService.gerarInfRespTec(xml)
    refute_nil xml
    assert_equal hash[:NFe][:infNFe][:infRespTec][:hashCSRT], "Njk2YmZhMmRlMTBjZTE3ZWFlZTNlYTgxMjM2Mzk4NjdjODJiOGEwYw=="
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
    assert_equal hash[:nfeResultMsg][:retConsReciNFe][:cStat], "106"
  end

  def test_is_the_assinarNF_is_working
    xml_unsigned = '<NFe><infNFe Id="NFe35221221684155000164550010000002361125429343"></infNFe></NFe>'
    xml, hash = @webService.assinarNF(xml_unsigned)
    refute_nil xml
    assert_equal hash[:NFe][:Signature][:SignedInfo][:Reference][:@URI], ("#" + hash[:NFe][:infNFe][:@Id])
    assert_equal hash[:NFe][:Signature][:SignedInfo][:Reference][:DigestValue], "651Y4oR2GTkXoHb0xyQoX142Nfw="
    assert_equal hash[:NFe][:Signature][:SignatureValue], "aCBtIaQBKNLVpN3Rj17qfaNlACz+YKfN/tzEtZFmigzniuPPMx8D5g4Kqx2ipuidZmu9iMYov9GLFA1ZadEwSzkf/Q+Q1cxZ7gLML8fBVKxK3owiLT7MAkJwNUoYHiVGmHykT2VA3BzBMypX6tpdo9+O1p36q/jXrt2G/xy3zyM0UFXKntDfpwbxyFEgBO04xE+ruFHiZmZYqvDjo8yzoWUxaeId3fMxtx/ZKqrBTtrwPMAMbY5G/my9s7Wj3XwdiJeTM11FWH42aeK5lzVtJa3w9hd5/zme3EUOZblpQrNLz45+V7T2u27vXNbtOwVdboTq9XdEQZN9WwJXD0/GPQ=="
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
    assert_equal msg["notas"][0]["erros"][0], "Rejeição[898]: Data de vencimento da parcela não informada ou menor que Data de Autorização."
  end

  def test_is_the_gerarDANFE_is_working
    xml = File.read("docs/nfe-valida-autorizada.xml")
    stat, pdf = @webService.gerarDANFE(xml)
    assert_equal stat, true
    refute_nil pdf
  end

  def test_is_the_inutilizarNF_is_working
    chaveInut = ""
    ano = "23"
    modelo = "55"
    serie = "1"
    nroNFIni = "23"
    nroNFFin = "23"
    justificativa = "Teste de inutilização"
    xml, hash = @webService.inutilizarNF(chaveInut, ano, modelo, serie, nroNFIni, nroNFFin, justificativa)
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
    chaveInut = @webService.calculaChaveInutilizacao(ano, cnpj, modelo, serie, nroNFIni, nroNFFin)
    assert_equal chaveInut, "ID35230101462500017555001000000023000000023"
  end

  def test_if_the_exportarInutilizarNF_is_working
    chaveInut = ""
    ano = "23"
    modelo = "55"
    serie = "1"
    nroNFIni = "23"
    nroNFFin = "23"
    justificativa = "Teste de inutilização"
    xml, hash = @webService.exportarInutilizarNF(chaveInut, ano, modelo, serie, nroNFIni, nroNFFin, justificativa)
    refute_nil xml
    assert_equal hash[:inutNFe][:infInut][:@Id], "ID35232168415500016455001000000023000000023"
  end

  def test_if_the_cancelarNF_is_working
    chaveNF = "35221221684155000164550010000002361125429343"
    sequenciaEvento = "1"
    dataHoraEvento = "2023-01-15T17:07:00+03:00"
    numProtocolo = "135220011515372"
    justificativa = "Teste de cancelamento..."
    idLote = "1"
    xml, hash = @webService.cancelarNF(chaveNF, sequenciaEvento, dataHoraEvento, numProtocolo, justificativa, idLote)
    refute_nil xml
    assert_equal hash[:nfeResultMsg][:retEnvEvento][:cStat], "128"
    assert_equal hash[:nfeResultMsg][:retEnvEvento][:retEvento][:infEvento][:cStat], "573"
  end

  def test_if_the_exportarCancelarNF_is_working
    chaveNF = "35221221684155000164550010000002361125429343"
    sequenciaEvento = "1"
    dataHoraEvento = "2023-01-15T17:07:00+03:00"
    numProtocolo = "135220011515372"
    justificativa = "Teste de cancelamento..."
    xml, hash = @webService.exportarCancelarNF(chaveNF, sequenciaEvento, dataHoraEvento, numProtocolo, justificativa)
    refute_nil xml
    assert_equal hash[:evento][:infEvento][:@Id], "ID1101113522122168415500016455001000000236112542934301"
  end

  def test_if_the_enviarCCe_is_working
    chaveNF = "35221221684155000164550010000002361125429343"
    sequenciaEvento = "1"
    dataHoraEvento = "2023-01-15T17:07:00+03:00"
    textoCorrecao = "Teste de carta de correção..."
    idLote = "1"
    xml, hash = @webService.enviarCCe(chaveNF, sequenciaEvento, dataHoraEvento, textoCorrecao, idLote)
    refute_nil xml
    assert_equal hash[:nfeResultMsg][:retEnvEvento][:cStat], "128"
    assert_equal hash[:nfeResultMsg][:retEnvEvento][:retEvento][:infEvento][:cStat], "573"
  end

  def test_if_the_exportarCCe_is_working
    chaveNF = "35221221684155000164550010000002361125429343"
    sequenciaEvento = "1"
    dataHoraEvento = "2023-01-15T17:07:00+03:00"
    textoCorrecao = "Teste de carta de correção..."
    xml, hash = @webService.exportarCCe(chaveNF, sequenciaEvento, dataHoraEvento, textoCorrecao)
    refute_nil xml
    assert_equal hash[:evento][:infEvento][:@Id], "ID1101103522122168415500016455001000000236112542934301"
  end

  def test_if_the_calculaChaveNF_is_working
    uf = "35"
    aamm = "2301"
    cnpj = "01014625000175"
    modelo = "55"
    serie = "1"
    nNF = "1234"
    tpEmis = "1"
    cNF = "171819"
    chaveNF, cDV = @webService.calculaChaveNF(uf, aamm, cnpj, modelo, serie, nNF, tpEmis, cNF)
    assert_equal chaveNF, "35230101014625000175550010000012341001718198"
    assert_equal cDV, 8
  end

  def test_if_the_enviarNF_is_working
    xml = File.read("docs/nfe-valida.xml")
    xml, hash = @webService.assinarNF(xml)
    indSinc = "0"
    idLote = "1"
    xml, hash = @webService.enviarNF(xml, indSinc, idLote)
    refute_nil xml
    refute_nil hash[:nfeResultMsg][:retEnviNFe][:cStat], "103"
  end

end
