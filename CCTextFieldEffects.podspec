Pod::Spec.new do |spec|
  spec.name                  = 'CCTextFieldEffects'
  spec.platform              = :ios
  spec.version               = '0.1.3'
  spec.license               = { :type => 'MIT' }
  spec.homepage              = 'https://github.com/Cokile/CCTextFieldEffects'
  spec.authors               = { 'Cokile' => 'kelvintgx@gmail.com' }
  spec.summary               = 'A simple replacement for UITextField.'
  spec.source                = { :git => 'https://github.com/Cokile/CCTextFieldEffects.git', :tag => 'v0.1.3'}
  spec.source_files          = 'CCTextFieldEffects/*.{h,m}'
  spec.resources             = 'CCTextFieldEffects/*.png'
  spec.requires_arc          = true
end
