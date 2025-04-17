#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint deeplink_x_macos.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'deeplink_x_macos'
  s.version          = '0.1.0'
  s.summary          = 'MacOS implementation of deeplink_x'
  s.description      = <<-DESC
MacOS implementation of deeplink_x
                       DESC
  s.homepage         = 'https://github.com/DeepLinkX/DeeplinkX'
  s.license          = { :type => 'MIT', :file => '../LICENSE' }
  s.author           = { 'Parham Hatanian' => 'parham.dev@gmail.com' }

  s.source           = { :path => '.' }
  s.source_files = 'deeplink_x_macos/Sources/deeplink_x_macos/**/*'

  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.15'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
