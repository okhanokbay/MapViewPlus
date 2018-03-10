//
//  BasicExampleViewController.swift
//  MapViewPlus
//
//  Created by Okhan on 07/03/2018.
//  Copyright © 2018 okhanokbay. All rights reserved.
//

import UIKit
import CoreLocation
import MapViewPlus

class BasicExampleViewController: UIViewController {
	
	@IBOutlet weak var mapView: MapViewPlus!
	weak var currentCalloutView: UIView?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationItem.title = "Basic Example"
		
		mapView.delegate = self //Required
		
		var annotations: [AnnotationPlus] = []
		
		annotations.append(AnnotationPlus.init(viewModel: BasicCalloutViewModel.init(title: "Cafe", image: UIImage(named: "cafe.png")!), coordinate: CLLocationCoordinate2DMake(50.11, 8.68)))
		
		annotations.append(AnnotationPlus.init(viewModel: BasicCalloutViewModel.init(title: "Factory", image: UIImage(named: "factory.png")!), coordinate: CLLocationCoordinate2DMake(50.85, 4.35)))

		annotations.append(AnnotationPlus.init(viewModel: BasicCalloutViewModel.init(title: "House", image: UIImage(named: "house.png")!), coordinate: CLLocationCoordinate2DMake(48.85, 2.35)))

		annotations.append(AnnotationPlus.init(viewModel: BasicCalloutViewModel.init(title: "Skyscraper", image: UIImage(named: "skyscraper.png")!), coordinate:CLLocationCoordinate2DMake(46.2039, 6.1400)))
		
		mapView.setup(withAnnotations: annotations)
		
		mapView.anchorViewCustomizerDelegate = self
	}
}

extension BasicExampleViewController: MapViewPlusDelegate {
	func mapView(_ mapView: MapViewPlus, imageFor annotation: AnnotationPlus) -> UIImage {
		return UIImage(named: "basic_annotation_image.png")!
	}
	
	func mapView(_ mapView: MapViewPlus, calloutViewFor annotationView: AnnotationViewPlus) -> CalloutViewPlus{
		let calloutView = Bundle.main.loadNibNamed("BasicCalloutView", owner: nil, options: nil)!.first as! BasicCalloutView
		calloutView.delegate = self
		currentCalloutView = calloutView
		return calloutView
	}
	
	// Optional
	func mapView(_ mapView: MapViewPlus, didAddAnnotations annotations: [AnnotationPlus]) {
		mapView.showAnnotations(annotations, animated: true)
	}
}

extension BasicExampleViewController: AnchorViewCustomizerDelegate {
	func mapView(_ mapView: MapViewPlus, fillColorForAnchorOf calloutView: CalloutViewPlus) -> UIColor {
		return currentCalloutView?.backgroundColor ?? mapView.defaultFillColorForAnchors
	}
}

extension BasicExampleViewController: BasicCalloutViewModelDelegate {
	func detailButtonTapped(withTitle title: String) {
		let alert = UIAlertController.init(title: "\(title) tapped", message: nil, preferredStyle: .alert)
		alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
}
