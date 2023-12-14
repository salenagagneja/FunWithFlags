# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'
inhibit_all_warnings!

target 'FunWithFlags' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for FunWithFlags
  pod 'IQKeyboardManagerSwift'
  pod 'Alamofire'
  pod 'FLEX', :git => 'https://github.com/FLEXTool/FLEX', :configurations => ['Debug']
  pod 'KeychainSwift'
  pod 'SwiftLint'
  pod 'Kingfisher', '~> 5.0'
  pod 'RxSwift', '6.0.0-rc.2'
  pod 'RxCocoa', '6.0.0-rc.2'
  pod 'SVGKit', :git => 'https://github.com/SVGKit/SVGKit.git', :branch => '3.x'
  
  # add pods for any other desired Firebase products
  # https://firebase.google.com/docs/ios/setup#available-pods
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      end
    end
  end

  target 'FunWithFlagsTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Quick'
    pod 'Nimble'
  end

  target 'FunWithFlagsUITests' do
    # Pods for testing
  end

end
