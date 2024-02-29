# frozen_string_literal: true

require "test_helper"

class SEFAZ::Webservice::SAT::TestClient < Minitest::Test

  def setup
    @client = SEFAZ::Webservice::SAT::Client.new
    @aut = File.read('test/fixtures/CFe/CFe-EnviarDadosVenda-Autorizado.xml')
    @canc = File.read('test/fixtures/CFe/CFe-CancelarUltimaVenda-Autorizado.xml')
    @infAdic = "Participe da Promoção de Natal: a cada 10 reais em compras ganhe um cupom."
  end

  def test_exportarCF_with_aut_invalid
    assert_raises(SEFAZ::ValidationError, "Layout do arquivo CFe-SAT inválido (Tipo de Arquivo: AUTORIZADO).") { @client.exportarCF(0, aut: {}, summary: false, infAdic: @infAdic) }
  end

  def test_exportarCF_with_canc_invalid
    assert_raises(SEFAZ::ValidationError, "Layout do arquivo CFe-SAT inválido (Tipo de Arquivo: CANCELAMENTO).") { @client.exportarCF(0, aut: @aut, canc: {}, summary: false, infAdic: @infAdic) }
  end

  def test_exportarCF_with_invalid_mm
    assert_raises(SEFAZ::NotImplemented, "Você deve implementar o método 'build' em uma subclasse.") { @client.exportarCF(0, aut: @aut, canc: @canc, summary: false, infAdic: @infAdic) }
  end

  def test_exportarCF_with_55mm
    pdf = @client.exportarCF(55, aut: @aut, summary: false, infAdic: @infAdic)
    File.open("test/fixtures/CFe/CFe-Autorizado-55mm.pdf", "w") { |f| f.write(pdf) }
    refute_nil(pdf)
  end

  def test_exportarCF_with_80mm
    pdf = @client.exportarCF(80, aut: @aut, summary: false, infAdic: @infAdic)
    File.open("test/fixtures/CFe/CFe-Autorizado-80mm.pdf", "w") { |f| f.write(pdf) }
    refute_nil(pdf)
  end

  def test_exportarCF_with_55mm_summary
    pdf = @client.exportarCF(55, aut: @aut, summary: true, infAdic: @infAdic)
    File.open("test/fixtures/CFe/CFe-Autorizado-Resumido-55mm.pdf", "w") { |f| f.write(pdf) }
    refute_nil(pdf)
  end

  def test_exportarCF_with_80mm_summary
    pdf = @client.exportarCF(80, aut: @aut, summary: true, infAdic: @infAdic)
    File.open("test/fixtures/CFe/CFe-Autorizado-Resumido-80mm.pdf", "w") { |f| f.write(pdf) }
    refute_nil(pdf)
  end

  def test_exportarCF_with_55mm_canc
    pdf = @client.exportarCF(55, aut: @aut, canc: @canc, summary: false, infAdic: @infAdic)
    File.open("test/fixtures/CFe/CFe-Cancelado-55mm.pdf", "w") { |f| f.write(pdf) }
    refute_nil(pdf)
  end

  def test_exportarCF_with_80mm_canc
    pdf = @client.exportarCF(80, aut: @aut, canc: @canc, summary: false, infAdic: @infAdic)
    File.open("test/fixtures/CFe/CFe-Cancelado-80mm.pdf", "w") { |f| f.write(pdf) }
    refute_nil(pdf)
  end

end
