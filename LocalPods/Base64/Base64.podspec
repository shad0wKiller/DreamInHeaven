Pod::Spec.new do |s|
  s.name             = "Base64"
  s.version          = "0.0.1"
  s.summary          = "Base64"
  s.source           = { :path => "./" }
  s.author           = "Base64"
  s.homepage         = "Base64"
  
  s.platform     = :ios, '7.0'
  s.requires_arc = false

  # s.compiler_flags = '-ObjC'
  s.xcconfig = { 
    # 'ONLY_ACTIVE_ARCH' => 'NO', 
    'ENABLE_BITCODE' => 'NO', 
  }

  s.source_files = [
    'Base64/Base64.h',
    'Base64/Base64.m',
    'Base64/Base64Define.h',
  ]

  s.frameworks = ['UIKit', 'Foundation', 'CoreLocation', 'Security']

end