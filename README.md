# MapViewPlus

[![Swift 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg?style=flat)](https://developer.apple.com/swift/)
![iOS 9.0+](https://img.shields.io/badge/iOS-9.0%2B-blue.svg)
[![Version](https://img.shields.io/cocoapods/v/MapViewPlus.svg?style=flat)](http://cocoapods.org/pods/MapViewPlus)
[![License](https://img.shields.io/cocoapods/l/MapViewPlus.svg?style=flat)](http://cocoapods.org/pods/MapViewPlus)
[![Platform](https://img.shields.io/cocoapods/p/MapViewPlus.svg?style=flat)](http://cocoapods.org/pods/MapViewPlus)

<img src="https://github.com/okhanokbay/MapViewPlus/blob/master/Example/basic_example_ld.gif" width=320> <img src="https://github.com/okhanokbay/MapViewPlus/blob/master/Example/default_callout_ld.gif" width=320>

## About

MapViewPlus gives you the missing methods of MapKit which are: ```imageForAnnotation``` and ```calloutViewForAnnotationView``` delegate methods.

- Return any UIImage from ```imageForAnnotation``` (image shouldn't have paddings)
- Create any UIView to use as your custom callout view and return it from ```calloutViewForAnnotationView```
- MapViewPlus will:
  1) Add an anchor view to bottom of your callout view
  2) Combine callout view with the anchor view and add shadow to both of them
  3) Add a cool animation to ```CalloutAndAnchorView```
  4) Make it user interaction enabled (this may be easy but tricky sometimes)
  5) Scrolls map view to show the callout view completely after tapping the annotation view
  5) Even give a ready-to-use template for callout view
  6) Forward all of the delegate methods of ```MKMapView``` to your subclass of ```MapViewPlus``` (except ```mapView:viewForAnnotation:```)


### Forwarding Delegate Methods

```MapViewPlus``` uses methods from ```MKMapViewDelegate```, but not all of them. It forwards all of the delegate methods except ```mapView:viewForAnnotation:```. This method is used internally and won't be redirected to your subclass.

Normally, ```MapViewPlus``` will abstract you from ```MapKit``` when you don't want to use the other methods of ```MKMapViewDelegate```. But when you want to use the other methods from ```MKMapViewDelegate```, you can easily do that without any extra efforts. Just write them down and they will get called by ```MapViewPlusDelegate```. Please see how ```mapView(_:regionDidChangeAnimated:)``` method is being called in ```DefaultCalloutViewController.swift``` (in the example project) even if you don't conform to ```MKMapViewDelegate```. If in the future, some new methods are added to ```MKMapViewDelegate```, they will be automagically forwarded to you by ```MapViewPlusDelegate``` without a new version of the framework. There is no wrapping occuring in the background.

## Requirements

**VERSION 0.1.0+:**
- Swift 4.0
- iOS 9.0+

## Installation

MapViewPlus is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MapViewPlus'
```

If you don't use CocoaPods, you can drag and drop all the classes and use it in your project.

## How to use

**1) If you are using Interface Builder, set your map view's class and module as MapViewPlus:**

<img src="https://github.com/okhanokbay/MapViewPlus/blob/master/Example/settings_and_module.png">


**2) Setup your Callout View Model:**

```swift
import UIKit
import MapViewPlus

// CalloutViewModel is a protocol of MapVieWPlus. Currently, it has no requirements to its conformant classes.
class YourCalloutViewModel: CalloutViewModel {

  var title: String
  var image: UIImage

  init(title: String, image: UIImage) {
    self.title = title
    self.image = image
  }
}
```

**3) Setup your CalloutView:**

- Create any view in an xib file (or programmatically):

<img src="https://github.com/okhanokbay/MapViewPlus/blob/master/Example/calloutview_example.png">

- Wire your view to your callout view class:

```swift
import UIKit
import MapViewPlus

// CalloutViewPlus is a protocol of MapViewPlus. 
// Currently, it has just one requirement -> func configureCallout(_ viewModel: CalloutViewModel)
class YourCalloutView: UIView, CalloutViewPlus {

  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var imageView: UIImageView!

  func configureCallout(_ viewModel: CalloutViewModel) {
    let viewModel = viewModel as! YourCalloutViewModel

    label.text = viewModel.title
    imageView.image = viewModel.image
  }
}
```

**4) Setup your Annotations in your View Controller:**

```swift
import UIKit
import CoreLocation
import MapViewPlus

class YourViewController: UIViewController {

  @IBOutlet weak var mapView: MapViewPlus!

  override func viewDidLoad() {
    super.viewDidLoad()

    //Required
    mapView.delegate = self

    let viewModel = YourCalloutViewModel(title: "Cafe", image: UIImage(named: "cafe.png")!)

    let annotation = AnnotationPlus(viewModel: viewModel,
                                    coordinate: CLLocationCoordinate2DMake(50.11, 8.68))

    var annotations: [AnnotationPlus] = []
    annotations.append(annotation)

    mapView.setup(withAnnotations: annotations)
  }
}
```

**5) Return the image for Annotation and the View for Callout**

```swift
extension YourViewController: MapViewPlusDelegate {

  func mapView(_ mapView: MapViewPlus, imageFor annotation: AnnotationPlus) -> UIImage {
    return UIImage(named: "your_annotation_image.png")!
  }

  func mapView(_ mapView: MapViewPlus, calloutViewFor annotationView: AnnotationViewPlus) -> CalloutViewPlus{
    let calloutView = Bundle.main.loadNibNamed("YourCalloutView", owner: nil, options: nil)!.first as! YourCalloutView
    return calloutView
  }
}

```

This is it. You are all set and ready to go now.

## Customization (Optional)

MapViewPlus is highly customizable:

### CalloutViewCustomizerDelegate

- Change the center of the callout view related to anchor view and callout view:

```swift
func mapView(_ mapView: MapViewPlus, centerForCalloutViewOf annotationView: AnnotationViewPlus) -> CalloutViewPlusCenter
```

- Change the bounds for callout view without changing the frames in Interface Builder. If you don't use this delegate method, then your callout view's frame will stay the same as the Interface Builder file. You can also use this to change frame dynamically according to the data in callout view!

```swift
func mapView(_ mapView: MapViewPlus, boundsForCalloutViewOf annotationView: AnnotationViewPlus) -> CalloutViewPlusBound
```

- Change the inset of anchor view related to callout view. Anchor view will go under the callout view as amount the value you returned from this method. Defaults to 0.

```swift
func mapView(_ mapView: MapViewPlus, insetFor calloutView: CalloutViewPlus) -> CGFloat
```

- Change the animation type for **showing** the callout view. Defaults to ```.fromBottom``` and available types are, ```.fromTop```, ```.fromBottom```, ```.fromLeft```, ```.fromRight```

```swift
func mapView(_ mapView: MapViewPlus, animationTypeForShowingCalloutViewOf annotationView: AnnotationViewPlus) -> CalloutViewShowingAnimationType
```

- Change the animation type for **hiding** the callout view. Defaults to ```.toBottom``` and available types are, ```.toTop```, ```.toBottom```, ```.toLeft```, ```.toRight```

```swift
func mapView(_ mapView: MapViewPlus, animationTypeForHidingCalloutViewOf annoationView: AnnotationViewPlus) -> CalloutViewHidingAnimationType
```

### AnchorViewCustomizerDelegate

- Change the height for anchor. Anchor view **will always draw a equilateral triangle** by taking the value you supplied as the triangle's height. You can change the height and the anchor view will calculate the necessary size for you:

```swift
func mapView(_ mapView: MapViewPlus, heightForAnchorOf calloutView: CalloutViewPlus) -> CGFloat
```

- Change the background color of anchor view. This is very important. You can supply any color you want for the anchor view. Generally you would like to make this color as same as the background color of your callout view. Just change it like:

```swift
func mapView(_ mapView: MapViewPlus, fillColorForAnchorOf calloutView: CalloutViewPlus) -> UIColor
```

## Notes

### DefaultCalloutView

- MapViewPlus supplies you a ready-to-go template for callout view. You can see the usage example of it in the example project.
- It allows you to specify the source of the image. It has three options:
  1) ```.downloadable(imageURL: URL, placeholder: UIImage?)```
      - Downloads the image with the help of Kingfisher framework
  2) ```.fromBundle(image: UIImage)```
  3) ```.none```

### Others

- This is an MVP and will be maintained and new features will be developed. Any help is appreciated.

- Uses protocol oriented MVVM approach inside the source itself. Tries to force users to use the same.

- If you want to add something, you can check future plans section

## Future plans

- Adding Kingfisher as subspec, with other options to download images as subspecs, too.

- Adding more templates and making them subspecs. So, anyone who needs a template won't have to download all of the templates. Any ideas or additions are appreciated.

- Annotation clustering (for both iOS 11 and iOS 11-) by utilizing native clustering in iOS 11 and using an open source clustering framework for iOS 11-

- Custom view option for annotations

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Screenshots

<img src="https://github.com/okhanokbay/MapViewPlus/blob/master/Example/basic_example_new.png" width=320> <img src="https://github.com/okhanokbay/MapViewPlus/blob/master/Example/default_callout_example_new.png" width=320>

## License

MapViewPlus is available under the MIT license. See the LICENSE file for more info.

