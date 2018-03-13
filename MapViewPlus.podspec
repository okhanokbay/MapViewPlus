#
# Be sure to run `pod lib lint MapViewPlus.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MapViewPlus'
  s.version          = '0.1.1'
  s.summary          = 'MKMapView + Image Annotation + Custom Callout View just by implementing 2 delegate methods. (Includes callout view template)'

  s.description      = <<-DESC
  MapViewPlus gives you the missing methods of MapKit which are: "imageForAnnotation" and "calloutViewForAnnotationView" delegate methods. Also gives you callout view template to use quickly. It allows you to customize the way you like with wide range of options. It also has some nice popping and disappearing animations. You do not need to know anything about MapKit to use MapViewPlus. It abstracts you from MapKit only if you want. Otherwise, you can also use all of the delegate methods of MapKit besides the delegate methods of MapViewPlus. MapViewPlus will redirect all of them to you except the one which is "viewForAnnotation" delegate method.
                       DESC

  s.homepage         = 'https://github.com/okhanokbay/MapViewPlus'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'okhanokbay' => 'okhanokbay5@gmail.com' }
  s.source           = { :git => 'https://github.com/okhanokbay/MapViewPlus.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.0'

  s.source_files = 'MapViewPlus/Classes/**/*'
  
   s.resource_bundles = {
     'MapViewPlus' => ['MapViewPlus/Assets/Assets.xcassets', 'MapViewPlus/Classes/DefaultCalloutView/DefaultCalloutView.xib']
   }

   s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'Kingfisher', '~> 4.6.3'
   
end
