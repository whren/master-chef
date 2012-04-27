
class IpVmDriver < VmDriver

  def initialize
    @ip = get_env("IP")
  end

  def ip
    @ip
  end

  def destroy
  end

end

