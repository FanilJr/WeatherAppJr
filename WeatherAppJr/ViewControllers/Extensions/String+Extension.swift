//
//  String+Extension.swift
//  WeatherAppJr
//
//  Created by Fanil_Jr on 09.11.2022.
//

import Foundation

extension String {
    var encodeURL: String
    {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decodeUrl: String
    {
    return self.removingPercentEncoding!
    }
}
