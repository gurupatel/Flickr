//
//  FlickrPhoto.swift
//  Flickr
//
//  Created by Gaurang Patel on 21/03/25.
//

import Foundation
import UIKit

// MARK: - Model: Defines the structure for the Flickr photo data
struct FlickrPhoto: Decodable {
    let title: String
    let media: Media

    struct Media: Decodable {
        let m: String
    }
}

struct FlickrResponse: Decodable {
    let items: [FlickrPhoto]
}
