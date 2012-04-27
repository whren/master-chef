
require 'rubygems'
require 'bundler/setup'

require 'test/unit'

require File.join(File.dirname(__FILE__), 'vm_helper.rb')
require File.join(File.dirname(__FILE__), 'http_helper.rb')

module VmTestHelper

  @vm = nil

  def setup
    @vm = vm = VM_DRIVER_CLAZZ.new
    @vm.init
    %x{#{@vm.format_chef_ssh "uname -a"}}
    assert_equal 0, $?.exitstatus
    puts "Virtual machine ready !"
    @http = ::HttpTester.new @vm
  end

  def teardown
    @vm.destroy if @vm
  end

end