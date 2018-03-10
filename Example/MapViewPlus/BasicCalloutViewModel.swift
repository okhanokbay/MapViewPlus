//
//  BasicCalloutViewModel.swift
//  MapViewPlus
//
//  Created by Okhan on 07/03/2018.
//  Copyright © 2018 okhanokbay. All rights reserved.
//

import UIKit
import MapViewPlus

class BasicCalloutViewModel: CalloutViewModel {
	var title: String
	var image: UIImage
	
	init(title: String, image: UIImage) {
		self.title = title
		self.image = image
	}
}
