//
//  ImagesHelper.swift
//  MapViewPlus
//
//  Created by Okhan on 10/03/2018.
//

import Foundation

public struct ImagesHelper {
	private static var podsBundle: Bundle {
		return Bundle(for: MapViewPlus.self)
	}
	
	private static func imageFor(name imageName: String) -> UIImage {
		return UIImage.init(named: imageName, in: podsBundle, compatibleWith: nil)!
	}
	
	public static var annotationImage: UIImage {
		return imageFor(name: "AnnotationImage")
	}
	
	public static var detailDisclosureDark: UIImage {
		return imageFor(name: "DetailDisclosureDark")
	}
	
	public static var detailDisclosureLight: UIImage {
		return imageFor(name: "DetailDisclosureLight")
	}
	
	public static var infoDark: UIImage {
		return imageFor(name: "InfoDark")
	}
	
	public static var infoLight: UIImage {
		return imageFor(name: "InfoLight")
	}
	
	public static var placeholderDark: UIImage {
		return imageFor(name: "PlaceholderDark")
	}
	
	public static var placeholderLight: UIImage {
		return imageFor(name: "PlaceholderLight")
	}
}
