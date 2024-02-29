# frozen_string_literal: true

require "test_helper"

class SEFAZ::Webservice::NFE::TestAuditor < Minitest::Test

  def test_is_the_auditor_is_connected
    xml = File.read("test/fixtures/NFe/NFe-enviarNF-Autorizado.xml")
    auditor = SEFAZ::Webservice::NFE::Auditor.new(xml)
    stat, msg = auditor.exec(60, 60)
    assert_equal stat, :ok
    assert_equal msg["notas"][0]["erros"][0], "Rejeição[898]: Data de vencimento da parcela não informada ou menor que Data de Autorização."
  end

end
