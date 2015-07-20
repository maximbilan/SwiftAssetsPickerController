//
//  RootListAssetsViewController.swift
//  SwiftAssetsPickerController
//
//  Created by Maxim Bilan on 6/5/15.
//  Copyright (c) 2015 Maxim Bilan. All rights reserved.
//

import UIKit
import Photos

enum AlbumType: Int {
	case AllPhotos
	case Favorites
	case Panoramas
	case Videos
	case TimeLapse
	case RecentlyDeleted
	case UserAlbum
	
	static let titles = ["All Photos", "Favorites", "Panoramas", "Videos", "Time Lapse", "Recently Deleted", "User Album"]
}

struct RootListItem {
	var title: String!
	var albumType: AlbumType
	var image: UIImage!
	var collection: PHAssetCollection?
}

class AssetsPickerController: UITableViewController, PHPhotoLibraryChangeObserver {
	
	private var items: Array<RootListItem>!
	private var activityIndicator: UIActivityIndicatorView!
	private let thumbnailSize = CGSizeMake(64, 64)
	private let reuseIdentifier = "RootListAssetsCell"
	
	// MARK: View controllers methods
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Navigation bar
		navigationItem.title = "Photos"
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelAction")
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "doneAction")
		navigationItem.rightBarButtonItem?.enabled = false
		
		// Activity indicator
		activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
		activityIndicator.hidesWhenStopped = true
		activityIndicator.center = self.view.center
		self.view.addSubview(activityIndicator)
		
		// Data
		items = Array()
		
		// Notifications
		PHPhotoLibrary.sharedPhotoLibrary().registerChangeObserver(self)
		
		// Load photo library
		loadData()
	}
	
	deinit {
		PHPhotoLibrary.sharedPhotoLibrary().unregisterChangeObserver(self)
	}
	
	// MARK: Data loading
	
	func loadData() {
		tableView.userInteractionEnabled = false
		activityIndicator.startAnimating()
		
		let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
		dispatch_async(dispatch_get_global_queue(priority, 0)) {
		
			self.items.removeAll(keepCapacity: false)
			
			let allPhotosItem = RootListItem(title: AlbumType.titles[AlbumType.AllPhotos.rawValue], albumType: AlbumType.AllPhotos, image: self.lastImageFromCollection(nil), collection: nil)
			let assetsCount = self.assetsCountFromCollection(nil)
			if assetsCount > 0 {
				self.items.append(allPhotosItem)
			}
			
			let smartAlbums = PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.SmartAlbum, subtype: PHAssetCollectionSubtype.AlbumRegular, options: nil)
			for var i: Int = 0; i < smartAlbums.count; ++i {
				if let smartAlbum = smartAlbums[i] as? PHAssetCollection {
					var item: RootListItem? = nil
					
					let assetsCount = self.assetsCountFromCollection(smartAlbum)
					if assetsCount == 0 {
						continue
					}
					
					switch smartAlbum.assetCollectionSubtype {
					case .SmartAlbumFavorites:
						item = RootListItem(title: AlbumType.titles[AlbumType.Favorites.rawValue], albumType: AlbumType.Favorites, image: self.lastImageFromCollection(smartAlbum), collection: smartAlbum)
						break
					case .SmartAlbumPanoramas:
						item = RootListItem(title: AlbumType.titles[AlbumType.Panoramas.rawValue], albumType: AlbumType.Panoramas, image: self.lastImageFromCollection(smartAlbum), collection: smartAlbum)
						break
					case .SmartAlbumVideos:
						item = RootListItem(title: AlbumType.titles[AlbumType.Videos.rawValue], albumType: AlbumType.Videos, image: self.lastImageFromCollection(smartAlbum), collection: smartAlbum)
						break
					case .SmartAlbumTimelapses:
						item = RootListItem(title: AlbumType.titles[AlbumType.TimeLapse.rawValue], albumType: AlbumType.TimeLapse, image: self.lastImageFromCollection(smartAlbum), collection: smartAlbum)
						break
						
					default:
						break
					}
					
					if item != nil {
						self.items.append(item!)
					}
				}
			}
			
			let topLevelUserCollections = PHCollectionList.fetchTopLevelUserCollectionsWithOptions(nil)
			for var i: Int = 0; i < topLevelUserCollections.count; ++i {
				if let userCollection = topLevelUserCollections[i] as? PHAssetCollection {
					let assetsCount = self.assetsCountFromCollection(userCollection)
					if assetsCount == 0 {
						continue
					}
					let item = RootListItem(title: userCollection.localizedTitle, albumType: AlbumType.UserAlbum, image: self.lastImageFromCollection(userCollection), collection: userCollection)
					self.items.append(item)
				}
			}
			
			dispatch_async(dispatch_get_main_queue()) {
				self.tableView.reloadData()
				self.activityIndicator.stopAnimating()
				self.tableView.userInteractionEnabled = true
			}
		}
	}
	
	// MARK: UITableViewDataSource
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
		
		cell.imageView?.image = items[indexPath.row].image
		cell.textLabel?.text = items[indexPath.row].title
		
		return cell
	}
	
	// MARK: UITableViewDelegate
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let assetsGrid = AssetsPickerGridController(collectionViewLayout: UICollectionViewLayout())
		assetsGrid.collection = items[indexPath.row].collection
		assetsGrid.title = items[indexPath.row].title
		navigationController?.pushViewController(assetsGrid, animated: true)
	}
	
	// MARK: Navigation bar actions
	
	func cancelAction() {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	func doneAction() {
		
	}
	
	// MARK: PHPhotoLibraryChangeObserver
	
	func photoLibraryDidChange(changeInstance: PHChange!) {
		loadData()
	}
	
	// MARK: Other
	
	func assetsCountFromCollection(collection: PHAssetCollection?) -> Int {
		let fetchResult = (collection == nil) ? PHAsset.fetchAssetsWithMediaType(.Image, options: nil) : PHAsset.fetchAssetsInAssetCollection(collection, options: nil)
		return fetchResult.count
	}
	
	func lastImageFromCollection(collection: PHAssetCollection?) -> UIImage? {
		
		var returnImage: UIImage? = nil
		
		let fetchOptions = PHFetchOptions()
		fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
		
		let fetchResult = (collection == nil) ? PHAsset.fetchAssetsWithMediaType(.Image, options: fetchOptions) : PHAsset.fetchAssetsInAssetCollection(collection, options: fetchOptions)
		if let lastAsset:PHAsset = fetchResult.lastObject as? PHAsset {
			
			let imageRequestOptions = PHImageRequestOptions()
			imageRequestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.FastFormat
			imageRequestOptions.resizeMode = PHImageRequestOptionsResizeMode.Exact
			imageRequestOptions.synchronous = true
			
			let retinaScale = UIScreen.mainScreen().scale
			let retinaSquare = CGSizeMake(thumbnailSize.width * retinaScale, thumbnailSize.height * retinaScale)
			
			let cropSideLength = min(lastAsset.pixelWidth, lastAsset.pixelHeight)
			let square = CGRectMake(CGFloat(0), CGFloat(0), CGFloat(cropSideLength), CGFloat(cropSideLength))
			let cropRect = CGRectApplyAffineTransform(square, CGAffineTransformMakeScale(1.0 / CGFloat(lastAsset.pixelWidth), 1.0 / CGFloat(lastAsset.pixelHeight)))
			
			imageRequestOptions.normalizedCropRect = cropRect
			
			PHImageManager.defaultManager().requestImageForAsset(lastAsset, targetSize: retinaSquare, contentMode: PHImageContentMode.AspectFit, options: imageRequestOptions, resultHandler: { (image: UIImage!, info :[NSObject : AnyObject]!) -> Void in
				returnImage = image
			})
		}
		
		return returnImage
	}
	
}