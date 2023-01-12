# frozen_string_literal: true

require "test_helper"

class TestNFE < Minitest::Test

  def setup
    @webService = SEFAZ::NFE.new
    @webService.setaAmbiente({ ambiente: "2", uf: "35" })
    @webService.setaPFXTss({ pfx: File.read("certificate.pfx"), senha: "1234" })
    @webService.setaPFXAss({ pfx: File.read("certificate.pfx"), senha: "1234" })
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

end
