
require 'test/unit'

require File.join(File.dirname(__FILE__), 'vm_helper.rb')

module VmTestHelper

  @vm = nil

  def setup
    @vm = vm = VM_DRIVER_CLAZZ.new
    @vm.init
    %x{#{@vm.format_root_ssh "uname -a"}}
    assert_equal 0, $?.exitstatus
  end

  def teardown
    @vm.destroy if @vm
  end
end