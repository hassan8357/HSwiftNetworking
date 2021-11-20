#
# Be sure to run `pod lib lint HSwiftNetworking.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HSwiftNetworking'
  s.version          = '2.1.2'
  s.summary          = 'This lib contains swift networking handler with routers, result & codable.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  This lib contains swift networking handler with routers, result & codable.
TODO: Add Comments and write read.me to discribe how it works.
                       DESC

  s.homepage         = 'https://github.com/hassan8357/HSwiftNetworking'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Hassan Refaat' => 'hassan.8357@gmail.com' }
  s.source           = { :git => 'https://github.com/hassan8357/HSwiftNetworking.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'

  s.source_files = 'HSwiftNetworking/Classes/**/*'
end
