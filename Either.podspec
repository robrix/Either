Pod::Spec.new do |spec|
  spec.name             = 'Either'
  spec.version          = '2.1.0'
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage         = 'https://github.com/robrix/Either'
  spec.authors          = { 'Rob Rix' => 'rob.rix@github.com' }
  spec.summary          = 'Swift µframework of Either, which represents two alternatives.'
  spec.source           = { :git => 'https://github.com/robrix/Either.git', :tag => spec.version.to_s }
  spec.source_files     = 'Either/*.swift'
  spec.dependency       'Prelude', '~> 3.0.0'
  spec.requires_arc     = true
  spec.ios.deployment_target = "8.0"
  spec.osx.deployment_target = "10.9"
end
