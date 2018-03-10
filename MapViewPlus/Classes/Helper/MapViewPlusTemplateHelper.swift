//
//  MapViewPlusTemplateHelper.swift
//  MapViewPlus
//
//  Created by Okhan on 18/08/17.
//  Copyright © 2017 okhanokbay. All rights reserved.
//

import Foundation

public class MapViewPlusTemplateHelper {
    public static var defaultCalloutView: DefaultCalloutView {
		let bundle = Bundle(for: MapViewPlus.self)
        return bundle.loadNibNamed("DefaultCalloutView", owner: nil, options: nil)!.first as! DefaultCalloutView
    }
}
