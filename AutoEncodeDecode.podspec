#
# Be sure to run `pod lib lint AutoEncodeDecode.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "AutoEncodeDecode"
  s.version          = "1.0.2"
  s.summary          = "Automatic encoding & decoding that conforms to NSCoding protocol"
  s.homepage         = "https://github.com/emailatravi/AutoEncodeDecode"
  s.license          = 'MIT'
  s.author           = { "Ravi Prakash Sahu" => "emailatravi@gmail.com" }
  s.source           = { :git => "https://github.com/emailatravi/AutoEncodeDecode.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/emailatravi'

  s.platform     = :ios, '5.0'
  s.requires_arc = false

  s.source_files = 'Pod/Classes/**/*'

  s.frameworks = 'Foundation'
  s.dependency 'ClassProperty', '~> 1.0.0'
end
