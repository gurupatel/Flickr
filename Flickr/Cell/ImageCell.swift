//
//  ImageCell.swift
//  Flickr
//
//  Created by Gaurang Patel on 21/03/25.
//

import Foundation
import UIKit

// MARK: - Custom CollectionView Cell
/// A UICollectionViewCell subclass that displays a Flickr photo with caching support.
class ImageCell: UICollectionViewCell {
    
    // MARK: - Cell Identifier
    /// Unique identifier for cell reuse
    static let identifier = "ImageCell"
    
    // MARK: - UI Elements
    /// Image view to display the photo
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill  // Ensures image fills the cell, cropping if necessary
        imageView.clipsToBounds = true             // Prevents content from overflowing
        imageView.layer.cornerRadius = 5           // Adds rounded corners for a softer look
        imageView.translatesAutoresizingMaskIntoConstraints = false // Enables Auto Layout
        return imageView
    }()
    
    // MARK: - Initializers
    /// Programmatic initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Add image view to the content view
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set up constraints to fill the entire cell
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        // Apply rounded corners to the cell content view
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
    }
    
    /// Required initializer for Storyboard/XIB (not used in this setup)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration Method
    /// Configures the cell with a Flickr photo object, supports caching for improved performance
    /// - Parameter photo: FlickrPhoto object containing the image URL
    func configure(with photo: FlickrPhoto) {
        // Check if the image is already cached
        if let cachedImage = ImageCache.shared.object(forKey: photo.media.m as NSString) {
            // Load cached image instantly
            imageView.image = cachedImage
        } else {
            // Fetch the image asynchronously if not cached
            DispatchQueue.global().async {
                if let url = URL(string: photo.media.m),
                   let data = try? Data(contentsOf: url),
                   let image = UIImage(data: data) {
                    // Cache the newly downloaded image
                    DispatchQueue.main.async {
                        ImageCache.shared.setObject(image, forKey: photo.media.m as NSString)
                        self.imageView.image = image
                    }
                }
            }
        }
    }
}
