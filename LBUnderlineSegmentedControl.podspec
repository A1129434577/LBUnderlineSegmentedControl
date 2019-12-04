Pod::Spec.new do |spec|
  spec.name         = "LBUnderlineSegmentedControl"
  spec.version      = "1.0.1"
  spec.summary      = "带下划线的自定义SegmentedControl"
  spec.description  = "带下划线的自定义SegmentedControl，支持自定义下划线颜色、长短、线粗、以及间距。"
  spec.homepage     = "https://github.com/A1129434577/LBUnderlineSegmentedControl"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "刘彬" => "1129434577@qq.com" }
  spec.platform     = :ios
  spec.ios.deployment_target = '8.0'
  spec.source       = { :git => 'https://github.com/A1129434577/LBUnderlineSegmentedControl.git', :tag => spec.version.to_s }
  spec.source_files = "LBUnderlineSegmentedControl/**/*.{h,m}"
  spec.requires_arc = true
end
