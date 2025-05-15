#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint moyoung_ble_plugin.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'moyoung_ble_plugin'
  s.version          = '1.0.79'
  s.summary          = 'A new Flutter project.'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  s.static_framework = true
  #  'Frameworks/RTKLEFoundation.framework', 'Frameworks/RTKOTASDK.framework',
  s.ios.vendored_frameworks = 'Frameworks/OTAFramework.framework', 'Frameworks/CRPSmartBand.framework', 'Frameworks/eZIPSDK.framework', 'Frameworks/SFDialPlateSDK.framework', 'Frameworks/SifliOTAManagerSDK.framework', 'Frameworks/ZipSDK.framework'
  # 'RTKLEFoundation.framework', 'RTKOTASDK.framework',
  s.vendored_frameworks = 'OTAFramework.framework', 'CRPSmartBand.framework', 'eZIPSDK.framework', 'SFDialPlateSDK.framework', 'SifliOTAManagerSDK.framework', 'ZipSDK.framework'

  s.dependency 'HandyJSON'


#   s.preserve_paths = 'CRPSmartBand.framework', 'OTAFramework.framework', 'RTKLEFoundation.framework', 'RTKOTASDK.framework'
#   s.xcconfig = { 'OTHER_LDFLAGS' => '-framework CRPSmartBand -framework OTAFramework -framework RTKLEFoundation -framework RTKOTASDK' }
#   s.vendored_frameworks = 'CRPSmartBand.framework', 'OTAFramework.framework', 'RTKLEFoundation.framework', 'RTKOTASDK.framework'
  
end
