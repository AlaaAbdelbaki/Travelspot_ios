  # Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Travelspot' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'Cards'
  pod 'GoogleSignIn'
  pod 'SOTabBar'
  pod 'Alamofire', '~> 4.7'
  pod 'AlamofireObjectMapper', '~> 5.2'
  pod 'CardParts'
  pod 'FaveButton'
  pod 'MapboxAnnotationExtension', '0.0.1-beta.1'
  pod 'Mapbox-iOS-SDK', '~> 5.2.0'
  pod 'MapboxGeocoder.swift', '~> 0.11'
  pod 'Kingfisher', '~> 5.15'
  pod "MaterialComponents/Cards"
 
  # Pods for Travelspot
  
  post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
      config.build_settings['LD_RUNPATH_SEARCH_PATHS'] = [
        '$(FRAMEWORK_SEARCH_PATHS)'
      ]
    end
  end

  target 'TravelspotTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TravelspotUITests' do
    # Pods for testing
  end

end
