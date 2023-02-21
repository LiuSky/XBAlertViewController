Pod::Spec.new do |s|
  s.name             = 'XBAlertViewController'
  s.version          = '1.2.0'
  s.summary          = '方便快捷的弹出框.'

  s.homepage         = 'https://github.com/LiuSky/XBAlertViewController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liuxiaobin' => '327847390@qq.com' }
  s.source           = { :git => 'https://github.com/LiuSky/XBAlertViewController.git', :tag => s.version.to_s }

  s.requires_arc = true
  s.swift_version         = '5.0'
  s.ios.deployment_target = '9.0'
  s.source_files = 'XBAlertViewController/Classes/**/*'
end
