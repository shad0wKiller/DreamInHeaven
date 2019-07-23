Pod::Spec.new do |s|
  s.name             = "TZImagePickerController"
  s.version          = "1.0.0"
  s.summary          = "TZImagePickerController library"
  s.source           = { :path => "./" }
  s.author           = "111"
  s.homepage         = "http://www.111.cn"
  
  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.prefix_header_contents = %(
    #ifdef __OBJC__

    #endif
  )

  # s.source_files = 'ModuleMaps/*.h'
  s.frameworks = ['UIKit', 'Foundation', 'CoreGraphics', 'CFNetwork', 'CoreTelephony', 'CoreText',
    'MobileCoreServices', 'SystemConfiguration', 'QuartzCore', 'CoreLocation', 'AdSupport', 'Security', 'ImageIO',
    'QuartzCore', 'MessageUI', 'AVFoundation'
  ]
  s.libraries = 'z','icucore','stdc++','sqlite3'


  s.source_files = [
    'TZImagePickerController/**/*.{h,m,mm,c}',
  ]
  s.resources = [
    'TZImagePickerController/**/*.{bundle}',
  ]

  s.vendored_libraries = [
    
  ]

end
