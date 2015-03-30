if defined?(ChefSpec)
  def start_pm2_application(name)
    ChefSpec::Matchers::ResourceMatcher.new(:pm2_application, :start, name)
  end

  def stop_pm2_application(name)
    ChefSpec::Matchers::ResourceMatcher.new(:pm2_application, :stop, name)
  end

  def restart_pm2_application(name)
    ChefSpec::Matchers::ResourceMatcher.new(:pm2_application, :restart, name)
  end

  def reload_pm2_application(name)
    ChefSpec::Matchers::ResourceMatcher.new(:pm2_application, :reload, name)
  end

  def graceful_reload_pm2_application(name)
    ChefSpec::Matchers::ResourceMatcher.new(:pm2_application, :graceful_reload, name)
  end

  def delete_pm2_application(name)
    ChefSpec::Matchers::ResourceMatcher.new(:pm2_application, :delete, name)
  end
end
