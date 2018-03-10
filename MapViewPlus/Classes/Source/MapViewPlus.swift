//
//  MapViewPlus
//
//  Created by Okhan Okbay on 10/03/2018
//
//  The MIT License (MIT)
//
//  Copyright (c) 2018 okhanokbay
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation
import MapKit

open class AnnotationViewPlus: MKAnnotationView {}

open class MapViewPlus: MKMapView {
	fileprivate weak var generalDelegate: MapViewPlusDelegate?
	public weak var calloutViewCustomizerDelegate: CalloutViewCustomizerDelegate?
    public weak var anchorViewCustomizerDelegate: AnchorViewCustomizerDelegate?
	
	fileprivate let pinID = "_MapViewPlusPinID"
	fileprivate var showingCalloutView: UIView?
	
	//These properties can be set via customizerDelegate.
	public fileprivate(set) var defaultHeightForAnchors: CGFloat = 16
    public fileprivate(set) var defaultInsetForCalloutView: CGFloat = 0
    public fileprivate(set) var defaultFillColorForAnchors: UIColor = UIColor.white
	
	public var calloutViewHorizontalInset: CGFloat = 8
	
	public fileprivate(set) var animator = MapViewPlusAnimator()
	
	open override var delegate: MKMapViewDelegate? {
		get {
			return super.delegate
		}
		set(delegate) {
			guard let delegate = delegate else { return }
			generalDelegate = delegate as? MapViewPlusDelegate
			super.delegate = self
		}
	}
	
	open func setup(withAnnotations annotations: [AnnotationPlus]) {
		DispatchQueue.main.async {
			for annotation in annotations {
				self.addAnnotation(annotation)
			}
			self.generalDelegate?.mapView(self, didAddAnnotations: annotations)
		}
	}
}

//MARK: Protocol Helper that forwards MKMapViewDelegate methods, if not handled by MapViewPlus, to subclass.
extension MapViewPlus {
	private func verifyProtocol(_ aProtocol: Protocol, contains aSelector: Selector) -> Bool {
		return protocol_getMethodDescription(aProtocol, aSelector, true, true).name != nil || protocol_getMethodDescription(aProtocol, aSelector, false, true).name != nil
	}
	
	open override func responds(to aSelector: Selector!) -> Bool {
		if verifyProtocol(MKMapViewDelegate.self, contains: aSelector) {
			return (super.responds(to: aSelector)) || (generalDelegate?.responds(to: aSelector) ?? false)
		}
		return super.responds(to: aSelector)
	}
	
	open override func forwardingTarget(for aSelector: Selector!) -> Any? {
		if verifyProtocol(MKMapViewDelegate.self, contains: aSelector) {
			return generalDelegate
		}
		return forwardingTarget(for: aSelector)
	}
}

extension MapViewPlus: MKMapViewDelegate {
	
	open func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		if annotation is MKUserLocation { return nil }
		var annotationView = self.dequeueReusableAnnotationView(withIdentifier: pinID)
		if annotationView == nil{
			annotationView = AnnotationViewPlus(annotation: annotation, reuseIdentifier: pinID)
			annotationView?.canShowCallout = false
		}else{
			annotationView?.annotation = annotation
		}
		annotationView?.image = generalDelegate?.mapView(self, imageFor: annotation as! AnnotationPlus)
		annotationView?.centerOffset = CGPoint(x: 0, y: -annotationView!.bounds.size.height * 0.5)

		return annotationView
	}
	
	open func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
		if view.annotation is MKUserLocation { return }
		
		let annotation = view.annotation as! AnnotationPlus
		let annotationView = view as! AnnotationViewPlus
		
		let calloutView = generalDelegate!.mapView(self, calloutViewFor: annotationView)
		calloutView.configureCallout(annotation.viewModel)
		
		let anchorView = getAnchorView(of: calloutView, relatedToAnnotationView: annotationView)
        customize(calloutView, and: anchorView, relatedTo: annotationView)
		
        let calloutAsView = calloutView as! UIView

		let combinedView = combine(calloutView, and: anchorView, relatedTo: annotationView)
		view.addSubview(combinedView)
		
		place(calloutView: calloutView, relatedToAnnotation: annotation, andAnnotationView: annotationView, anchorView)
		
		let animationType = calloutViewCustomizerDelegate?.mapView(self, animationTypeForShowingCalloutViewOf: annotationView) ?? self.animator.defaultShowingAnimationType
		
		self.animator.show(calloutAsView, andAnchorView: anchorView, combinedView: combinedView, withType: animationType) 
		
		generalDelegate?.mapView?(self, didSelect: view)
	}
	
	private func place(calloutView: CalloutViewPlus, relatedToAnnotation annotation: AnnotationPlus, andAnnotationView annotationView: AnnotationViewPlus, _ anchorView: AnchorView) {
		
		let inset = calloutViewCustomizerDelegate?.mapView(self, insetFor: calloutView) ?? defaultInsetForCalloutView
		
		let calloutAsView = calloutView as! UIView
		
		let bottomOfAnnotation = self.convert(annotation.coordinate, toPointTo: self)
		let bottomOfAnnotationView = CGPoint(x: bottomOfAnnotation.x, y: bottomOfAnnotation.y)
		
		let padding: CGFloat = 8
		
		var xAddition: CGFloat = 0
		var yAddition: CGFloat = 0
		
		let conditionalWidth = calloutAsView.bounds.width / 2 + padding
		let conditionalHeight = calloutAsView.bounds.height + annotationView.bounds.height + anchorView.bounds.height + inset + padding
		
		if bottomOfAnnotationView.x - conditionalWidth < 0 {
			xAddition = bottomOfAnnotationView.x - conditionalWidth
			
		}else if bottomOfAnnotationView.x + conditionalWidth > bounds.width {
			xAddition = conditionalWidth - (bounds.width - bottomOfAnnotationView.x)
		}
		
		if bottomOfAnnotationView.y - conditionalHeight < 0 {
			yAddition = -(conditionalHeight - bottomOfAnnotationView.y)
		}
		
		let coordinateForNewCenterOfMapView = self.convert(CGPoint(x: self.bounds.width / 2 + xAddition , y: self.bounds.height / 2 + yAddition) , toCoordinateFrom: self)
		self.setCenter(coordinateForNewCenterOfMapView, animated: true)
	}
	
	open func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
		if view.annotation is MKUserLocation { return }
		
		for subview in view.subviews {
			guard subview is CalloutAndAnchorView else { return }
			
			let annotationView = view as! AnnotationViewPlus
			let animationType = calloutViewCustomizerDelegate?.mapView(self, animationTypeForHidingCalloutViewOf: annotationView) ?? self.animator.defaultHidingAnimationType
			self.animator.hide(subview, withAnimationType: animationType, completion: { [weak self] in
				self?.showingCalloutView = nil
			})
		}
		
		generalDelegate?.mapView?(self, didDeselect: view)
	}
	
	open func removeAllAnnotations() {
		let annotations = self.annotations.filter { [weak self] in
			return ($0 !== self?.userLocation)
		}
		self.removeAnnotations(annotations)
	}
}

extension MapViewPlus: UIGestureRecognizerDelegate {
	public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
		return !(touch.view is UIControl)
	}
}

extension MapViewPlus {
	open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		guard let showingCalloutView = showingCalloutView else {
			return super.hitTest(point, with: event)
		}
		return showingCalloutView.hitTest(showingCalloutView.convert(point, from: self), with: event) ?? super.hitTest(point, with: event)
	}
}

//MARK: AnchorView Generator
extension MapViewPlus {
    fileprivate func getAnchorView(of calloutView: CalloutViewPlus, relatedToAnnotationView annotationView: AnnotationViewPlus) -> AnchorView {
        let anchorHeight = anchorViewCustomizerDelegate?.mapView(self, heightForAnchorOf: calloutView) ?? defaultHeightForAnchors
        let anchorFillColor = anchorViewCustomizerDelegate?.mapView(self, fillColorForAnchorOf: calloutView)
		
        return AnchorViewHelper().getDefaultAnchor(withHeight: anchorHeight, fillColor: anchorFillColor)
    }
}

//MARK: CalloutView Generator 
extension MapViewPlus {
    fileprivate func customize(_ calloutView: CalloutViewPlus, and anchorView: AnchorView, relatedTo annotationView: AnnotationViewPlus) {
        let centerForCalloutView = calloutViewCustomizerDelegate?.mapView(self, centerForCalloutViewOf: annotationView) ?? .defaultCenter
        let boundsForCalloutView = calloutViewCustomizerDelegate?.mapView(self, boundsForCalloutViewOf: annotationView) ?? .defaultBounds
     	let inset = calloutViewCustomizerDelegate?.mapView(self, insetFor: calloutView) ?? defaultInsetForCalloutView
		
        let calloutAsView = calloutView as! UIView
        showingCalloutView = calloutAsView
		
        switch centerForCalloutView {
        case CalloutViewPlusCenter.defaultCenter:
            calloutAsView.center =  CGPoint(x: annotationView.bounds.size.width / 2,
														   y: (-calloutAsView.bounds.height / 2) + (-anchorView.bounds.size.height) + (-inset))
        case CalloutViewPlusCenter.customCenter(let center):
            calloutAsView.center = center
        }
		
        switch boundsForCalloutView {
        case CalloutViewPlusBound.defaultBounds: break
        case CalloutViewPlusBound.customBounds(let bounds):
            calloutAsView.bounds = bounds
        }
    }
}

extension MapViewPlus {
    fileprivate func combine(_ calloutView: CalloutViewPlus, and anchorView: AnchorView, relatedTo annotationView: AnnotationViewPlus) -> CalloutAndAnchorView {
        let calloutAsView = calloutView as! UIView

        let calloutAndAnchorView = CalloutAndAnchorView(frame:
            CGRect.init(x: calloutAsView.frame.origin.x,
                        y: calloutAsView.frame.origin.y,
                        width: calloutAsView.frame.size.width,
                        height: calloutAsView.frame.size.height + anchorView.bounds.size.height),
                                                        calloutView: calloutView,
                                                        anchorView: anchorView)
		
        return calloutAndAnchorView
    }
}


