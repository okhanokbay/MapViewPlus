//
//  MapViewPlusDelegate.swift
//  MapViewPlus
//
//  Created by Okhan on 18/08/17.
//  Copyright © 2017 okhanokbay. All rights reserved.
//

import UIKit
import MapKit

public protocol MapViewPlusDelegate: MKMapViewDelegate {
    // You can return different images for different annotations, as you see.
    func mapView(_ mapView: MapViewPlus, imageFor annotation: AnnotationPlus) -> UIImage
    
    // You must return a CalloutViewPlusProtocol conformant here, because, while MapViewPlus is building the callout view, it uses the conformance.
    func mapView(_ mapView: MapViewPlus, calloutViewFor annotationView: AnnotationViewPlus) -> CalloutViewPlus
	
	// Optional
	// This method name is chosen to prevent conflicts.
	// If you don't want any callbacks, then skip this method.
    func mapView(_ mapView: MapViewPlus, didAddAnnotations annotations: [AnnotationPlus])
}

public extension MapViewPlusDelegate {
	func mapView(_ mapView: MapViewPlus, didAddAnnotations annotations: [AnnotationPlus]) {}
}

public protocol CalloutViewCustomizerDelegate: class {
    // Center for callout view is the position of calloutview related to its annotation view.
    // You can return any CalloutViewPlusCenter options here
    // defaultCenter makes callout view centered related to annotation view. If you don't conform to this protocol, defaultCenter is used.
    // customCenter lets you customize the position of callout view related to annotation view
    func mapView(_ mapView: MapViewPlus, centerForCalloutViewOf annotationView: AnnotationViewPlus) -> CalloutViewPlusCenter
    
    // Bound for callout view is actually the size of the callout view.
    // You can return any CalloutViewPlusBound options here
    // defaultBounds makes callout view as the same size as it is in the interface builder, or the same size as how you built it.
    // customBounds lets you customize the size of callout view
    func mapView(_ mapView: MapViewPlus, boundsForCalloutViewOf annotationView: AnnotationViewPlus) -> CalloutViewPlusBound
    
    // Optional
    // It sets the negative inset for anchor view
    func mapView(_ mapView: MapViewPlus, insetFor calloutView: CalloutViewPlus) -> CGFloat
	
	// Optional
	// Return the desired animation type to be used while showing the callout view
	func mapView(_ mapView: MapViewPlus, animationTypeForShowingCalloutViewOf annotationView: AnnotationViewPlus) -> CalloutViewShowingAnimationType
	
	// Optional
	// Return the desired animation type to be used while hiding the callout view
	func mapView(_ mapView: MapViewPlus, animationTypeForHidingCalloutViewOf annoationView: AnnotationViewPlus) -> CalloutViewHidingAnimationType
}

public extension CalloutViewCustomizerDelegate {
    public func mapView(_ mapView: MapViewPlus, insetFor calloutView: CalloutViewPlus) -> CGFloat {
        return mapView.defaultInsetForCalloutView
    }
	
	public func mapView(_ mapView: MapViewPlus, animationTypeForShowingCalloutViewOf annotationView: AnnotationViewPlus) -> CalloutViewShowingAnimationType {
		return CalloutViewShowingAnimationType.fromBottom
	}
	
	public func mapView(_ mapView: MapViewPlus, animationTypeForHidingCalloutViewOf annoationView: AnnotationViewPlus) -> CalloutViewHidingAnimationType {
		return CalloutViewHidingAnimationType.toBottom
	}
}

public protocol AnchorViewCustomizerDelegate: class {
	// Optional
    // The height returned from this method will be used as the height of the anchor triangle
    // Line heights will be calculated upon this value to generate a equilateral triangle
    // Every anchor is an equilateral triangle
    func mapView(_ mapView: MapViewPlus, heightForAnchorOf calloutView: CalloutViewPlus) -> CGFloat
    
    //Optional
    // The color returned from this method will be used to fill the anchor triangle.
    func mapView(_ mapView: MapViewPlus, fillColorForAnchorOf calloutView: CalloutViewPlus) -> UIColor
}

public extension AnchorViewCustomizerDelegate {
	func mapView(_ mapView: MapViewPlus, heightForAnchorOf calloutView: CalloutViewPlus) -> CGFloat {
		return mapView.defaultHeightForAnchors
	}
	
    public func mapView(_ mapView: MapViewPlus, fillColorForAnchorOf calloutView: CalloutViewPlus) -> UIColor {
        return mapView.defaultFillColorForAnchors
    }
}
