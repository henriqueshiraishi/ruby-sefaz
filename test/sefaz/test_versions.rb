# frozen_string_literal: true

require "test_helper"

class TestVersion < Minitest::Test

  def test_if_gem_has_a_version_number
    refute_nil ::SEFAZ::VERSION
  end

  def test_if_savon_has_a_version_number
    refute_nil ::Savon::VERSION
  end

end
