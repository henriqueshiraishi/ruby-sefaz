# frozen_string_literal: true

require "test_helper"

class TestValidador < Minitest::Test

  def test_is_the_validador_is_connected
    xml = File.read("docs/nfe-valida-autorizada.xml")
    validador = SEFAZ::Utils::Validador.new(xml)
    stat, msg, err = validador.executar(60, 60)
    assert_equal stat, :ok
    assert_equal msg.length, 3
    assert_equal err.length, 0
  end

end
