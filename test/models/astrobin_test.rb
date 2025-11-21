require 'test_helper'

class AstrobinTest < ActiveSupport::TestCase
  test 'username is stripped of leading whitespace' do
    astrobin = Astrobin.create!(username: '   leading_space')
    assert_equal 'leading_space', astrobin.username
  end

  test 'username is stripped of trailing whitespace' do
    astrobin = Astrobin.create!(username: 'trailing_space   ')
    assert_equal 'trailing_space', astrobin.username
  end

  test 'username is stripped of leading and trailing whitespace' do
    astrobin = Astrobin.create!(username: '   both_spaces   ')
    assert_equal 'both_spaces', astrobin.username
  end

  test 'username case is preserved' do
    astrobin = Astrobin.create!(username: 'MixedCASE')
    assert_equal 'MixedCASE', astrobin.username
  end

  test 'username with mixed case and extra whitespace is normalized' do
    astrobin = Astrobin.create!(username: '  AstroBinUser123  ')
    assert_equal 'AstroBinUser123', astrobin.username
  end

  test 'username is normalized on update' do
    astrobin = Astrobin.create!(username: 'original')
    astrobin.update!(username: '  UPDATED  ')
    assert_equal 'UPDATED', astrobin.username
  end
end
