

Pod::Spec.new do |s|

  s.name         = "UIDebuggingTool"
  s.version      = "0.2.0"
  s.summary      = "A tool to enable UIDebuggingInformationOverlay for iOS"
  s.description  = <<-DESC
  A tool to help aid in visual debugging by using UIDebuggingInformationOverlay
                   DESC
  s.homepage     = "https://github.com/whf5566/UIDebuggingTool"
  s.license      = "MIT"
  s.author             = { "whf5566" => "whf5566@gamil.com" }
  s.social_media_url   = "http://wellphone.me"

  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/whf5566/UIDebuggingTool.git", :tag => "#{s.version}" }
  s.source_files  = "UIDebuggingTool/UIDebuggingTool/*.{h,m}"
  s.public_header_files = "UIDebuggingTool/UIDebuggingTool/*.h"

end
