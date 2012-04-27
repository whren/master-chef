require File.join(File.dirname(__FILE__), 'test_helper.rb')

class BaseTest < Test::Unit::TestCase

  include VmTestHelper

  def test_ok
    @vm.run "uname -a"
  end

  def test_ko
    assert_raise RuntimeError do
      @vm.run "toto"
    end
  end

  def test_run_chef
    @vm.run_chef
  end

end