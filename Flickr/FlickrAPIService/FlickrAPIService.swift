//
//  FlickrAPIService.swift
//  Flickr
//
//  Created by Gaurang Patel on 21/03/25.
//

import Foundation
import UIKit

// MARK: - Image Cache
/// Singleton to handle image caching for better performance and avoid repeated downloads
class ImageCache {
    /// Shared instance of NSCache for storing images
    static let shared = NSCache<NSString, UIImage>()
}

// MARK: - API Service
/// Handles fetching data from the Flickr API and decoding the response
class FlickrAPIService {
    
    // MARK: - API Endpoint
    /// URL for fetching public images from Flickr API (JSON format)
    private let apiURL = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"
    
    // MARK: - Fetch Images Method
    /// Fetches images from the Flickr API and returns a list of `FlickrPhoto` objects
    /// - Parameter completion: A closure that returns an optional array of `FlickrPhoto`
    func fetchImages(completion: @escaping ([FlickrPhoto]?) -> Void) {
        
        // Ensure the URL is valid, exit early if not
        guard let url = URL(string: apiURL) else {
            print("❌ Invalid API URL")
            completion(nil)
            return
        }
        
        // MARK: - Network Request
        /// Create a URL session data task to fetch data from the API
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // Handle network errors or missing data
            guard let data = data, error == nil else {
                print("❗️Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            // MARK: - JSON Decoding
            /// Try decoding the fetched JSON data into a `FlickrResponse` object
            do {
                let decodedData = try JSONDecoder().decode(FlickrResponse.self, from: data)
                
                // Return the array of photos (items)
                completion(decodedData.items)
                
            } catch {
                // Handle JSON parsing errors
                print("🔍 Failed to decode JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }
        .resume()  // Starts the network task
    }
}
