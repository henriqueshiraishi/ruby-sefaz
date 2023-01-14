# frozen_string_literal: true

require "test_helper"

class TestAuditor < Minitest::Test

  def test_is_the_auditor_is_connected
    xml = File.read("docs/nfe-valida-autorizada.xml")
    auditor = SEFAZ::Utils::Auditor.new(xml)
    stat, msg = auditor.executar(60, 60)
    assert_equal stat, :ok
    assert_equal msg["notas"][0]["valido"], "XML Válido"
  end

end
