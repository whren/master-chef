require File.join(File.dirname(__FILE__), 'test_helper.rb')

class Framework < Test::Unit::TestCase

  include VmTestHelper

  def test_ok
    @vm.run_root "uname -a"
  end

  def test_ko
    assert_raise RuntimeError do
      @vm.run_root "toto"
    end
  end

end