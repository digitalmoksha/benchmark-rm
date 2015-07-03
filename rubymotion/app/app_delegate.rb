class AppDelegate

  # OS X entry point
  #------------------------------------------------------------------------------
  def applicationDidFinishLaunching(notification)
    benchmark_this
    NSRunningApplication.currentApplication.terminate
  end

  # iOS entry point
  #------------------------------------------------------------------------------
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    true
  end

end