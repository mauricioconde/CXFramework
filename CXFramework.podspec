Pod::Spec.new do |s|
  s.name			= "CXFramework"
  s.version			= "1.0.0"
  s.summary			= "CX Framework"
  s.homepage			= "https://github.com/mauricioconde/CXFramework"
  s.license			= { :type => 'private', :file => 'LICENSE' }
  s.author			= "Mauricio Conde Xinastle"
  s.source			= { :path => '.' }  
  
  s.swift_version 		= '5.0'
  
  s.platform     		= :ios, "11.0"
  s.ios.deployment_target 	= "11.0"
  
  s.source_files 		= "CXFramework/Classes/**/*"  
  s.resources			= "CXFramework/Assets/**/*.{json,png,xcassets,storyboard,xib,strings,stringsdict,bundle}"
  s.exclude_files 		= "CXFramework/**/*.plist"
  
  s.frameworks 			= "UIKit"
  # Uncomment if this pod will be installed from a .framework
  #s.vendored_frameworks 	= 'CXFramework.framework'
end