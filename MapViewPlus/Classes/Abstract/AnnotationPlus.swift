//
//  AnnotationPlus.swift
//  MapViewPlus
//
//  Created by Okhan on 18/08/17.
//  Copyright © 2017 okhanokbay. All rights reserved.
//

import Foundation
import MapKit

open class AnnotationPlus: NSObject, MKAnnotation {
    open var viewModel: CalloutViewModel
    open var coordinate: CLLocationCoordinate2D
    
    public init(viewModel: CalloutViewModel, coordinate: CLLocationCoordinate2D) {
        self.viewModel = viewModel
        self.coordinate = coordinate
    }
}
