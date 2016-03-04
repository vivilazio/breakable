require 'test_helper'

class BreakableTest < ActiveSupport::TestCase
  def test_that_it_has_a_version_number
    refute_nil ::Breakable::VERSION
  end

  def test_it_break_the_body_field
    article = articles(:prova)
    assert article.full_text
    assert(article.medium_text.length == 500, article.medium_text.length)
    assert(article.small_text.length == 300, article.small_text.length)

    gift = gifts(:prova)
    assert gift.full_text
    assert(gift.medium_text.length == 500, gift.medium_text.length)
    assert(gift.small_text.length == 300, gift.small_text.length)
  end
end
