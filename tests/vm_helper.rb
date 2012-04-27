
CHEF_USER = ENV["CHEF_USER"] || "chef"

def exec_local cmd
  begin
    raise "#{cmd} failed. Aborting..." unless system cmd
  rescue
    raise "#{cmd} failed. Aborting..."
  end
end

def get_env name
  abort "Please specify #{name} variable" unless ENV[name]
  ENV[name]
end

require File.join(File.dirname(__FILE__), 'vm_driver.rb')

test_dir = File.dirname(__FILE__)
Dir["#{test_dir}/*_vm_driver.rb"].each do |f|
  require f
end

vm_driver = "#{get_env "VM_DRIVER"}VmDriver"
puts "Using VM_DRIVER #{vm_driver}"
abort "VM_DRIVER not found #{vm_driver}" unless Object.const_defined? vm_driver
VM_DRIVER_CLAZZ = Kernel.const_get vm_driver
