# frozen_string_literal: true

require "test_helper"

class SEFAZ::Webservice::NFE::TestDataset < Minitest::Test

  def test_is_the_dataset_is_working
    chaveNF = "35221221684155000164550010000002361125429343"
    dataset = SEFAZ::Webservice::NFE::Dataset.new(chaveNF)
    
    dataset.ide.cUF = "35"
    dataset.emit.CNPJ = "XXX.XXX.XXX/XXXX-XX"
    dataset.emit.xNome = "XXXXXXXXXXXXXXXXXXXX"
    dataset.dest.CNPJ = "ZZZ.ZZZ.ZZZ/ZZZZ-ZZ"
    dataset.dest.xNome = "ZZZZZZZZZZZZZZZZZZZZ"

    dataset.add("REBOQUE") do |reboque|
      reboque.placa = "XX"
      reboque.UF = "XX"
      reboque.RNTC = "XX"
    end

    dataset.add("REBOQUE") do |reboque|
      reboque.placa = "ZZ"
      reboque.UF = "ZZ"
      reboque.RNTC = "ZZ"
    end

    dataset.infAdic.infCpl = "Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptates perferendis velit vitae a, nam id cumque architecto optio. Repellendus dolorem quas nam vel odit temporibus provident natus, accusamus molestiae in?"
    xml, hash = dataset.gerarNF

    assert_equal xml, '<NFe xmlns="http://www.portalfiscal.inf.br/nfe"><infNFe Id="NFe35221221684155000164550010000002361125429343" versao="4.00"><ide><cUF>35</cUF></ide><emit><CNPJ>XXX.XXX.XXX/XXXX-XX</CNPJ><xNome>XXXXXXXXXXXXXXXXXXXX</xNome></emit><dest><CNPJ>ZZZ.ZZZ.ZZZ/ZZZZ-ZZ</CNPJ><xNome>ZZZZZZZZZZZZZZZZZZZZ</xNome></dest><transp><reboque><placa>XX</placa><UF>XX</UF><RNTC>XX</RNTC></reboque><reboque><placa>ZZ</placa><UF>ZZ</UF><RNTC>ZZ</RNTC></reboque></transp><infAdic><infCpl>Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptates perferendis velit vitae a, nam id cumque architecto optio. Repellendus dolorem quas nam vel odit temporibus provident natus, accusamus molestiae in?</infCpl></infAdic></infNFe></NFe>'
    assert_equal hash[:NFe][:infNFe][:@Id], "NFe35221221684155000164550010000002361125429343"
    assert_equal hash[:NFe][:infNFe][:@versao], "4.00"
    assert_equal hash[:NFe][:infNFe][:ide][:cUF], "35"
    assert_equal hash[:NFe][:infNFe][:emit][:CNPJ], "XXX.XXX.XXX/XXXX-XX"
    assert_equal hash[:NFe][:infNFe][:dest][:CNPJ], "ZZZ.ZZZ.ZZZ/ZZZZ-ZZ"
    assert_equal hash[:NFe][:infNFe][:transp][:reboque].class, Array
    assert_equal hash[:NFe][:infNFe][:transp][:reboque].length, 2
    assert_equal hash[:NFe][:infNFe][:transp][:reboque].first[:placa], 'XX'
    assert_equal hash[:NFe][:infNFe][:transp][:reboque].last[:placa], 'ZZ'
    assert_equal hash[:NFe][:infNFe][:infAdic][:infCpl], "Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptates perferendis velit vitae a, nam id cumque architecto optio. Repellendus dolorem quas nam vel odit temporibus provident natus, accusamus molestiae in?"
  end

end
