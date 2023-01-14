# frozen_string_literal: true

require "test_helper"

class TestDANFE < Minitest::Test

  def test_is_the_danfe_is_connected
    xml = File.read("docs/nfe-valida-autorizada.xml")
    gerador = SEFAZ::Utils::DANFE.new(xml)
    stat, pdf = gerador.executar(60, 60)
    assert_equal stat, :ok
    refute_nil pdf
  end

end
