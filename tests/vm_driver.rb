
class VmDriver

  def format_chef_ssh cmd
    "ssh -o StrictHostKeyChecking=no #{CHEF_USER}@#{ip} #{cmd}"
  end

  def run cmd
    begin
      raise "ssh #{CHEF_USER} : #{cmd} failed. Aborting..." unless system format_chef_ssh(cmd) 
    rescue
      raise "ssh #{CHEF_USER} : #{cmd} failed. Aborting..."
    end
  end

  def run_chef
    run "/etc/chef/update.sh"
  end

end
