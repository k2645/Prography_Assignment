# Uncomment the next line to define a global platform for your project
platform :ios, '17.2'

target 'PrographyAssignment' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for PrographyAssignment
  
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Kingfisher'
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "17.2"
      end
    end
  end

end
