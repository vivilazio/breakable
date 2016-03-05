require 'test_helper'

class BreakableTest < ActiveSupport::TestCase
  def test_that_it_has_a_version_number
    refute_nil ::Breakable::VERSION
  end

  def test_it_breaks_the_body_field
    article = articles(:prova)
    gift = gifts(:prova)
    thing = things(:prova)

    assert article.respond_to?(:full_text)
    assert(article.long_teaser.length == 500, article.long_teaser.length)
    assert(article.teaser.length == 300, article.teaser.length)

    assert gift.respond_to?(:full_text)
    assert(gift.long_teaser.length == 0, gift.long_teaser.length)
    assert(gift.teaser.length == 0, gift.teaser.length)

    assert thing.respond_to?(:full_text)
    assert(thing.long_teaser.length == 500, thing.long_teaser.length)
    assert(thing.teaser.length == 300, thing.teaser.length)
  end
end
