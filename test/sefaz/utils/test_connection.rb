# frozen_string_literal: true

require "test_helper"

class TestConnection < Minitest::Test

  def setup
    certificate = File.read("certificateSignature.pfx")
    password = "1234"
    @pkcs12 = OpenSSL::PKCS12.new(certificate, password)
  end

  def test_if_the_certificate_is_working
    refute_nil @pkcs12.certificate
    refute_nil @pkcs12.key
  end

  def test_if_the_connection_is_working
    wsdl = SEFAZ::Utils::WSDL.get(:NfeStatusServico, "2", "35")
    conn = SEFAZ::Utils::Connection.new(@pkcs12, wsdl, "4.00", "35")
    assert_equal conn.connected?, true
  end

end
