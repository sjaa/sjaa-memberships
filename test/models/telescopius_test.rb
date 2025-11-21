require 'test_helper'

class TelescopiusTest < ActiveSupport::TestCase
  test 'username is stripped of leading whitespace' do
    telescopius = Telescopius.create!(username: '   leading_space')
    assert_equal 'leading_space', telescopius.username
  end

  test 'username is stripped of trailing whitespace' do
    telescopius = Telescopius.create!(username: 'trailing_space   ')
    assert_equal 'trailing_space', telescopius.username
  end

  test 'username is stripped of leading and trailing whitespace' do
    telescopius = Telescopius.create!(username: '   both_spaces   ')
    assert_equal 'both_spaces', telescopius.username
  end

  test 'username case is preserved' do
    telescopius = Telescopius.create!(username: 'MixedCASE')
    assert_equal 'MixedCASE', telescopius.username
  end

  test 'username with mixed case and extra whitespace is normalized' do
    telescopius = Telescopius.create!(username: '  TelescopiusUser123  ')
    assert_equal 'TelescopiusUser123', telescopius.username
  end

  test 'username is normalized on update' do
    telescopius = Telescopius.create!(username: 'original')
    telescopius.update!(username: '  UPDATED  ')
    assert_equal 'UPDATED', telescopius.username
  end
end
