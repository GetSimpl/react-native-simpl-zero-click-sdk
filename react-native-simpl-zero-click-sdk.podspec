require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = "react-native-simpl-zero-click-sdk"
  s.version      = package['version']
  s.summary      = "React Native wrapper for Simpl ZeroClick SDK"

  s.homepage     = "https://github.com/GetSimpl/react-native-simpl-zero-click-sdk.git"
  s.authors      = { "Simpl" => "devarajan@getsimpl.com" }
  s.license      = package['license']
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/GetSimpl/react-native-simpl-zero-click-sdk.git", :tag => "v#{s.version}" }
  s.source_files  = "src/ios/**/*.{h,m}"

  s.dependency 'React'
  s.dependency 'SimplZeroClick'
end
