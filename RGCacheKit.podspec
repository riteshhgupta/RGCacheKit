Pod::Spec.new do |spec|
  spec.name         =  'RGCacheKit'
  spec.version      =  '1.0'
  spec.summary   =  'RGCacheKit - Coredata helper'
  spec.author = {
    'Ritesh Gupta' => 'rg.riteshh@gmail.com'  
  }
  spec.license          =  'MIT' 
  spec.homepage         =  'https://github.com/riteshhgupta/RGCacheKit'
  spec.source = {
    :git => 'https://github.com/riteshhgupta/RGCacheKit.git',
    :tag => '1.0'
  }
  spec.ios.deployment_target = "10.0"
  spec.requires_arc =  true
  spec.source_files =  'Source/**/*.swift'

end
