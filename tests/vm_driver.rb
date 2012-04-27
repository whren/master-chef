
class VmDriver

  def format_chef_ssh cmd
    config = File.join(File.dirname(__FILE__), "ssh", "config") 
    ssh_key = File.join(File.dirname(__FILE__), "ssh", "id_rsa")
    %x{chmod 0600 #{ssh_key} && rm -f /tmp/tmp_known_hosts}
    "ssh -F #{config} -i #{ssh_key} #{CHEF_USER}@#{ip} #{cmd}"
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

  def upload_json json
    json_file = File.join(File.dirname(__FILE__), "json", json)
    exec_local "scp #{json_file} #{CHEF_USER}@#{ip}:/tmp/local.json"
    self.run "sudo mv /tmp/local.json /etc/chef/local.json"
  end

end
