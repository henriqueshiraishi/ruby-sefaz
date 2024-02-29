# frozen_string_literal: true

require "test_helper"

class SEFAZ::Webservice::NFE::TestValidator < Minitest::Test

  def test_is_the_validador_is_connected
    xml = File.read("test/fixtures/NFe/NFe-enviarNF-Autorizado.xml")
    validator = SEFAZ::Webservice::NFE::Validator.new(xml)
    stat, msg, err = validator.exec(60, 60)
    assert_equal stat, :ok
    assert_equal msg.length, 3
    assert_equal err.length, 0
  end

end
