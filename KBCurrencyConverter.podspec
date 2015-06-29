#
# Be sure to run `pod lib lint KBCurrencyConverter.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "KBCurrencyConverter"
  s.version          = "0.0.2"
  s.summary          = "Currency converter for iOS using jsonrates.com"
  s.description      = <<-DESC
                       Currency converter for iOS using ReactiveCocoa and AFNetworking
                       DESC
  s.homepage         = "https://github.com/badeleux/KBCurrencyConverter"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "badeleux" => "badeleux@gmail.com" }
s.source           = { :git => "https://github.com/badeleux/KBCurrencyConverter.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'KBCurrencyConverter' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'ReactiveCocoa'
  s.dependency 'AFNetworking-RACExtensions'
end
