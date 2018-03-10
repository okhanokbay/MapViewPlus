//
//  DefaultCalloutViewThemeManager.swift
//  MapViewPlus
//
//  Created by Okhan on 21/08/17.
//  Copyright © 2017 okhanokbay. All rights reserved.
//

import UIKit

final class DefaultCalloutViewThemeManager {
    public static func getBackgroundColor(of theme: DefaultCalloutViewTheme) -> UIColor {
        return theme == .light ? UIColor.white : UIColor.darkGray
    }
    
    public static func getItemColor(of theme: DefaultCalloutViewTheme) -> UIColor {
        return theme == .light ? UIColor.darkGray : UIColor.white
    }
    
    public static func getDetailDisclosureButtonImage(of theme: DefaultCalloutViewTheme) -> UIImage {
        return theme == .light ? ImagesHelper.detailDisclosureDark : ImagesHelper.detailDisclosureLight
    }
    
    public static func getInfoButtonImage(of theme: DefaultCalloutViewTheme) -> UIImage {
        return theme == .light ? ImagesHelper.infoDark : ImagesHelper.infoLight
    }
    
    public static func getPlaceholderImage(of theme: DefaultCalloutViewTheme) -> UIImage {
        return theme == .light ? ImagesHelper.placeholderDark : ImagesHelper.placeholderLight
    }
    
    public static func getAnchorFillColor(of theme: DefaultCalloutViewTheme) -> UIColor {
        return theme == .light ? UIColor.white : UIColor.darkGray
    }
    
    public static func getBorderColorForCalloutAndAnchor(of theme: DefaultCalloutViewTheme) -> UIColor {
        return theme == .light ? UIColor.darkGray : UIColor.white
    }
}
