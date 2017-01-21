# Uncomment this line to define a global platform for your project
#platform :ios, '9.0'

target 'cApp' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for cApp
  pod 'Charts', '~>2.3.0'

  target 'cAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'cAppUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        # Configure Pod targets for Xcode 8 compatibility
        config.build_settings['SWIFT_VERSION'] = '2.3'
    end
end
