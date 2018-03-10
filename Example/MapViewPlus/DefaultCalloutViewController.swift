//
//  ViewController.swift
//  MapViewPlus
//
//  Created by Okhan on 18/08/17.
//  Copyright © 2017 okhanokbay. All rights reserved.
//

import UIKit
import MapKit
import MapViewPlus
import CoreLocation

class DefaultCalloutViewController: UIViewController {
    
    @IBOutlet weak var mapView: MapViewPlus!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.navigationItem.title = "Default Callout View"
        
        let annotations = [
            AnnotationPlus.init(viewModel: DefaultCalloutViewModel.init(title: "Paris"), coordinate: CLLocationCoordinate2DMake(48.85, 2.35)),
			
			AnnotationPlus.init(viewModel: DefaultCalloutViewModel.init(title: "Geneva", subtitle: "Switzerland", imageType: .downloadable(imageURL: URL.init(string: "https://media.istockphoto.com/photos/urban-view-with-famous-fountain-geneva-switzerland-hdr-picture-id477159306?k=6&m=477159306&s=612x612&w=0&h=NwvReV5kYj0M939OkdVenOSQvU4d0eGmqJcbwx_Qsr4=")!, placeholder: #imageLiteral(resourceName: "PlaceholderDark")), theme: .light, detailButtonType: .detailDisclosure), coordinate: CLLocationCoordinate2DMake(46.2039, 6.1400)),
			
            AnnotationPlus.init(viewModel: DefaultCalloutViewModel.init(title: "Brussels", imageType: .downloadable(imageURL: URL.init(string: "https://cdn.pixabay.com/photo/2016/07/22/14/58/brussels-1534989_960_720.jpg")!, placeholder: #imageLiteral(resourceName: "PlaceholderLight")), theme: .dark, detailButtonType: .info), coordinate: CLLocationCoordinate2DMake(50.85, 4.35))]
        
        mapView.delegate = self // Must conform to this to make it work.
        mapView.setup(withAnnotations: annotations)
    }
}

extension DefaultCalloutViewController: MapViewPlusDelegate {
    func mapView(_ mapView: MapViewPlus, imageFor annotation: AnnotationPlus) -> UIImage {
        return #imageLiteral(resourceName: "AnnotationImage")
    }
    
    func mapView(_ mapView: MapViewPlus, calloutViewFor annotationView: AnnotationViewPlus) -> CalloutViewPlus{
        let calloutView = MapViewPlusTemplateHelper.defaultCalloutView
		
		// Below two are:
		// Required if DefaultCalloutView is being used
		// Optional if you are using your own callout view
        mapView.calloutViewCustomizerDelegate = calloutView
        mapView.anchorViewCustomizerDelegate = calloutView
		
		//Optional. Conform to this if you want button click delegate method to be called.
		calloutView.delegate = self
		
        return calloutView
    }
	
	// Optional
	func mapView(_ mapView: MapViewPlus, didAddAnnotations annotations: [AnnotationPlus]) {
		mapView.showAnnotations(annotations, animated: true)
	}
	
	// Optional. Just to show that delegate forwarding is actually working.
	func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
		print("This method is being forwarded to you by MapViewPlusDelegate")
	}
}

extension DefaultCalloutViewController: DefaultCalloutViewDelegate {
	func buttonDetailTapped(with viewModel: DefaultCalloutViewModelProtocol, buttonType: DefaultCalloutViewButtonType) {
		let alert = UIAlertController(title: buttonType == .background ? "Background Tapped" : "Detail Button Tapped", message: viewModel.title + "  " + (viewModel.subtitle ?? ""), preferredStyle: .alert)
		let confirmAction = UIAlertAction(title: "OK", style: .default, handler: nil)
		alert.addAction(confirmAction)
		self.present(alert, animated: true, completion: nil)
    }
}

