# frozen_string_literal: true

require "test_helper"

class SEFAZ::Utils::TestConnection < Minitest::Test

  def setup
    cert = File.read("certs/server.pfx")
    pass = "020607"
    @pkcs12 = OpenSSL::PKCS12.new(cert, pass)
  end

  def test_if_the_certificate_is_working
    refute_nil @pkcs12.certificate
    refute_nil @pkcs12.key
  end

  def test_if_the_connection_is_working
    wsdl = SEFAZ::Webservice::NFE::WSDL.get(:NfeStatusServico, "2", "35")
    conn = SEFAZ::Utils::Connection.new(@pkcs12, wsdl, {})
    assert_equal conn.connected?, true
  end

end
