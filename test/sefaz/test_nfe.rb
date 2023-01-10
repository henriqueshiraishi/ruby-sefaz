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
    assert_equal response[:nfe_result_msg][:ret_cons_stat_serv][:c_stat], "242"
  end

end
