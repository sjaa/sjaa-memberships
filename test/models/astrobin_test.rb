require 'test_helper'

class AstrobinTest < ActiveSupport::TestCase
  test 'username is saved in lowercase' do
    astrobin = Astrobin.create!(username: 'UPPERCASE')
    assert_equal 'uppercase', astrobin.username
  end

  test 'username is saved without leading whitespace' do
    astrobin = Astrobin.create!(username: '   leading_space')
    assert_equal 'leading_space', astrobin.username
  end

  test 'username is saved without trailing whitespace' do
    astrobin = Astrobin.create!(username: 'trailing_space   ')
    assert_equal 'trailing_space', astrobin.username
  end

  test 'username is saved without leading and trailing whitespace' do
    astrobin = Astrobin.create!(username: '   both_spaces   ')
    assert_equal 'both_spaces', astrobin.username
  end

  test 'username is saved in lowercase and without whitespace' do
    astrobin = Astrobin.create!(username: '   MixedCASE   ')
    assert_equal 'mixedcase', astrobin.username
  end

  test 'username with mixed case and extra whitespace is normalized' do
    astrobin = Astrobin.create!(username: '  AstroBinUser123  ')
    assert_equal 'astrobinuser123', astrobin.username
  end

  test 'username is normalized on update' do
    astrobin = Astrobin.create!(username: 'original')
    astrobin.update!(username: '  UPDATED  ')
    assert_equal 'updated', astrobin.username
  end
end
