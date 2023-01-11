# frozen_string_literal: true

require "test_helper"

class TestNFE < Minitest::Test

  def test_if_the_nfe_is_connected
    certificate = File.read("certificate.pfx")
    password = "1234"
    nfe = SEFAZ::NFE.new("2", "35", certificate, password)
    assert_equal nfe.connected?, true
  end

  def test_if_the_statusDoServico_is_working
    certificate = File.read("certificate.pfx")
    password = "1234"
    nfe = SEFAZ::NFE.new("2", "35", certificate, password)
    response = nfe.statusDoServico
    assert_equal response[:nfe_result_msg][:ret_cons_stat_serv][:c_stat], "107"
  end

  def test_is_the_consultarNF_is_working
    chaveNF = "35221221684155000164550010000002361125429343"
    certificate = File.read("certificate.pfx")
    password = "1234"
    nfe = SEFAZ::NFE.new("2", "35", certificate, password)
    response = nfe.consultarNF(chaveNF)
    assert_equal response[:nfe_result_msg][:ret_cons_sit_n_fe][:c_stat], "101"
  end

  def test_is_the_consultarCadastro_is_working
    nroDocumento = "01.014.625/0001-75"
    tpDocumento = "CNPJ"
    uf = "SP"
    certificate = File.read("certificate.pfx")
    password = "1234"
    nfe = SEFAZ::NFE.new("2", "35", certificate, password)
    response = nfe.consultarCadastro(nroDocumento, tpDocumento, uf)
    assert_equal response[:nfe_result_msg][:ret_cons_cad][:inf_cons][:c_stat], "259"
  end

end
