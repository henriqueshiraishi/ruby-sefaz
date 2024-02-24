# frozen_string_literal: true

require "test_helper"

class SEFAZ::Webservice::SAT::Dataset::TestCancel < Minitest::Test

  def test_is_the_dataset_is_working
    chCanc = "35221221684155000164550010000002361125429343"
    dataset = SEFAZ::Webservice::SAT::Dataset::Cancel.new(chCanc)
    
    dataset.ide.CNPJ = "0101462500175"
    dataset.ide.signAC = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    dataset.ide.numeroCaixa = "1"
    xml, hash = dataset.gerarCF

    assert_equal xml, '<CFeCanc><infCFe chCanc="CFe35221221684155000164550010000002361125429343"><ide><CNPJ>0101462500175</CNPJ><signAC>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</signAC><numeroCaixa>1</numeroCaixa></ide><emit></emit><dest></dest><total></total><infAdic></infAdic></infCFe></CFeCanc>'
    assert_equal hash[:CFeCanc][:infCFe][:@chCanc], "CFe35221221684155000164550010000002361125429343"
    assert_equal hash[:CFeCanc][:infCFe][:ide][:CNPJ], "0101462500175"
    assert_equal hash[:CFeCanc][:infCFe][:ide][:signAC], "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    assert_equal hash[:CFeCanc][:infCFe][:ide][:numeroCaixa], "1"
  end

end
