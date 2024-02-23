# frozen_string_literal: true

require "test_helper"

class SEFAZ::Webservice::NFE::TestWSDL < Minitest::Test

  def test_if_the_wsdl_is_working
    wsdl = SEFAZ::Webservice::NFE::WSDL.get(:NfeStatusServico, "2", "35")
    refute_nil wsdl
  end
  
end
