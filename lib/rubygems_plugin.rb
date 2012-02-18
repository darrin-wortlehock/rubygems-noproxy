require 'rubygems/remote_fetcher'

class Gem::RemoteFetcher

  def no_proxy_patterns
    @no_proxy_patterns ||= begin
      env_no_proxy = ENV['no_proxy'] || ENV['NO_PROXY']
      if env_no_proxy.nil? or env_no_proxy.empty?
        []
      else
        env_no_proxy.split(/\s*,\s*/)
      end
    end
  end

  def no_proxy?(host)
    host = host.downcase
    no_proxy_patterns.each do |pattern|
      pattern = pattern.downcase
      return true if host[-pattern.length, pattern.length] == pattern
    end
    return false
  end
  
  def connection_for(uri)
    net_http_args = [uri.host, uri.port]

    if @proxy_uri && !no_proxy?(uri.host) then
      net_http_args += [
        @proxy_uri.host,
        @proxy_uri.port,
        @proxy_uri.user,
        @proxy_uri.password
      ]
    end

    connection_id = [Thread.current.object_id, *net_http_args].join ':'
    @connections[connection_id] ||= Net::HTTP.new(*net_http_args)
    connection = @connections[connection_id]

    if uri.scheme == 'https' and not connection.started? then
      require 'net/https'
      connection.use_ssl = true
      connection.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    connection.start unless connection.started?

    connection
  rescue Errno::EHOSTDOWN => e
    raise FetchError.new(e.message, uri)
  end

end
