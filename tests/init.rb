require 'rubygems'
require 'bundler/setup'
require File.join(File.dirname(__FILE__), 'vm_helper.rb')

vm = VM_DRIVER_CLAZZ.new
vm.init

puts "Vm created, ip #{vm.ip}"