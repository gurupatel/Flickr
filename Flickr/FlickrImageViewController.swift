//
//  FlickrImageViewController.swift
//  Flickr
//
//  Created by Gaurang Patel on 20/03/25.
//

import UIKit

// MARK: - View Controller: Manages UI and interactions
/// This ViewController handles displaying Flickr images in a UICollectionView.
/// It manages API calls, UI setup, and collection view layout configuration.
class FlickrImageViewController: UIViewController {
    
    // MARK: - Properties
    /// Array to hold the fetched Flickr photos
    private var photos: [FlickrPhoto] = []
    
    /// Service responsible for fetching images from the Flickr API
    private let service = FlickrAPIService()
    
    /// Outlet connected to the CollectionView in the storyboard
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionViewLayout()
        fetchImages()
    }
    
    // MARK: - UI Setup
    /// Sets up the UI elements, including registering the cell and configuring the view
    private func setupUI() {
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        title = "Flickr Images"
        view.backgroundColor = .white
    }
    
    // MARK: - CollectionView Layout Setup
    /// Configures the layout of the collection view for a 2-column grid with padding
    func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let padding: CGFloat = 10
        let itemsPerRow: CGFloat = 2
        
        // Calculate cell width based on screen size and padding
        let totalPadding = padding * (itemsPerRow + 1)
        let itemWidth = (view.frame.width - totalPadding) / itemsPerRow
        
        // Set item size with a 4:3 aspect ratio (adjust if needed)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 0.75)
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        collectionView.collectionViewLayout = layout
        
        // Add padding around the content
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.backgroundColor = .white
    }
    
    // MARK: - Fetch Images
    /// Fetches images from the Flickr API and reloads the collection view on the main thread
    private func fetchImages() {
        service.fetchImages { [weak self] photos in
            DispatchQueue.main.async {
                self?.photos = photos ?? [] // Ensure photos is never nil
                self?.collectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionView DataSource & DelegateFlowLayout Extension
/// Extension to handle CollectionView DataSource and DelegateFlowLayout methods
extension FlickrImageViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Data Source Methods
    
    /// Returns the number of items (photos) in the section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    /// Configures and returns a cell for a given index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }
        
        // Get the corresponding photo and configure the cell
        let photo = photos[indexPath.item]
        cell.configure(with: photo)
        return cell
    }
}
