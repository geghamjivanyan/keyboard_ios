platform :ios, '15.0'

project 'Keyboard.xcodeproj'

target 'KeyboardHost' do
  use_frameworks!
  
  target 'Keyboard' do
    inherit! :search_paths
    # Add a basic dependency to ensure the Podfile is valid
    pod 'SnapKit', '~> 5.6.0'  # A popular layout framework that might be useful for keyboard UI
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
    end
  end
end 