#
# Be sure to run `pod lib lint DLTriangle.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "DLTriangle"
  s.version          = "1.0"
  s.summary          = "Class implementing Möller-Trumbore algorithm to allow fast and easy triangle/ray intersection checks"
#s.description      = <<-DESC
#                       An optional longer description of DLTriangle
#
#                       * Markdown format.
#                       * Don't worry about the indent, we strip it!
#                       DESC
  s.homepage         = "https://github.com/dlajarretie/DLTriangle"
  s.license          = 'MIT'
  s.author           = { "Damien Lajarretie" => "dlajarretie@airintservices.com" }
  s.source           = { :git => "https://github.com/dlajarretie/DLTriangle.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
end
