#
# Be sure to run `pod lib lint CAFFImageSwitch.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CAFFImageSwitch"
  s.version          = "0.1.0"
  s.summary          = "UISwitch-like control with customizable images for `on` and `off` states. Based on https://github.com/bvogelzang/SevenSwitch."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                       DESC

  s.homepage         = "https://github.com/caffco/CAFFImageSwitch"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'GPLv2'
  s.author           = { "Lluís Ulzurrun de Asanza i Sàez" => "lluis@caff.co" }
  s.source           = { :git => "https://github.com/caffco/CAFFImageSwitch.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/sumolari'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  # s.resource_bundles = {
  #   'CAFFImageSwitch' => ['Pod/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
