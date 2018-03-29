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

public struct ImagesHelper {
	private static var podsBundle: Bundle {
		let bundle = Bundle(for: MapViewPlus.self)
		return Bundle(url: bundle.url(forResource: "MapViewPlus", withExtension: "bundle")!)!
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
