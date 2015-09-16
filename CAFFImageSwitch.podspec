Pod::Spec.new do |s|

  s.name         = "CAFFImageSwitch"
  s.version      = "0.0.1"
  s.summary      = "UISwitch-like control with customizable images for `on` and `off` states. Based on https://github.com/bvogelzang/SevenSwitch."

  s.description  = <<-DESC
                   UISwitch-like control with customizable images for `on` and `off` states.
                   Based on https://github.com/bvogelzang/SevenSwitch.
                   DESC

  s.homepage     = "http://caff.co/"
  s.license      = "GPLv2"
  s.author             = { "Lluís Ulzurrun de Asanza i Sàez" => "lluis@caff.co" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/caffco/CAFFImageSwitch.git", :tag => '0.0.1' }

  s.source_files  = "CaffImageSwitchExample", "CaffImageSwitchExample/**/*.{h,m}"

  s.requires_arc = true

end
