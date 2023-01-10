# frozen_string_literal: true

require "test_helper"

class TestConnection < Minitest::Test

  def test_if_the_certificate_is_working
    certificate = File.read("certificate.pfx")
    password = "1234"
    pkcs12 = OpenSSL::PKCS12.new(certificate, password)
    refute_nil pkcs12.certificate
    refute_nil pkcs12.key
  end

  def test_if_the_connection_is_working
    certificate = File.read("certificate.pfx")
    password = "1234"
    pkcs12 = OpenSSL::PKCS12.new(certificate, password)
    version, wsdl = SEFAZ::Utils::WSDL.get(:NfeStatusServico, "2", "35")
    conn = SEFAZ::Utils::Connection.new(pkcs12, wsdl, version, "35")
    assert_equal conn.connected?, true
  end

end
