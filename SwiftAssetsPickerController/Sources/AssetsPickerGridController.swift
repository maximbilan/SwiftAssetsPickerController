//
//  AssetsGridViewController.swift
//  SwiftAssetsPickerController
//
//  Created by Maxim Bilan on 6/5/15.
//  Copyright (c) 2015 Maxim Bilan. All rights reserved.
//

import UIKit
import Photos

class AssetsPickerGridController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
	
	let cachingImageManager = PHCachingImageManager()
	var collection: PHAssetCollection?
	private let reuseIdentifier = "AssetsGridCell"
	
	private var assets: [PHAsset]! {
		willSet {
			cachingImageManager.stopCachingImagesForAllAssets()
		}
		
		didSet {
			cachingImageManager.startCachingImagesForAssets(self.assets, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.AspectFill, options: nil)
		}
	}
	private var assetGridThumbnailSize: CGSize = CGSizeMake(0, 0)
	
	override init(collectionViewLayout layout: UICollectionViewLayout) {
		super.init(collectionViewLayout: layout)
	}

	required init(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
		
		collectionView?.collectionViewLayout = flowLayout
		collectionView?.backgroundColor = UIColor.whiteColor()
		collectionView?.registerClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: reuseIdentifier)
		
		let scale = UIScreen.mainScreen().scale;
		let cellSize = flowLayout.itemSize
		assetGridThumbnailSize = CGSizeMake(cellSize.width * scale, cellSize.height * scale);
		
		let assetsFetchResult = (collection == nil) ? PHAsset.fetchAssetsWithMediaType(.Image, options: nil) : PHAsset.fetchAssetsInAssetCollection(collection, options: nil)
		assets = assetsFetchResult.objectsAtIndexes(NSIndexSet(indexesInRange: NSMakeRange(0, assetsFetchResult.count))) as! [PHAsset]
	}
	
	// MARK: UICollectionViewDelegate
	
	
	// MARK: UICollectionViewDataSource
	
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return assets.count
	}
	
	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
		cell.backgroundColor = UIColor.blackColor()
		
		let currentTag = cell.tag + 1
		cell.tag = currentTag
		
		var thumbnail: UIImageView!
		var typeIcon: UIImageView!
		if cell.contentView.subviews.count == 0 {
			thumbnail = UIImageView(frame: cell.contentView.frame)
			thumbnail.contentMode = .ScaleAspectFill
			thumbnail.clipsToBounds = true
			cell.contentView.addSubview(thumbnail)
			
			typeIcon = UIImageView(frame: CGRectMake(3, cell.contentView.frame.size.height - 3 - 20, 20, 20))
			typeIcon.contentMode = .ScaleAspectFill
			typeIcon.clipsToBounds = true
			cell.contentView.addSubview(typeIcon)
		}
		else {
			thumbnail = cell.contentView.subviews[0] as! UIImageView
			typeIcon = cell.contentView.subviews[1] as! UIImageView
		}
		
		let asset = assets[indexPath.row]
		
		typeIcon.image = nil
		if asset.mediaType == .Video {
			if asset.mediaSubtypes == .VideoTimelapse {
				typeIcon.image = UIImage(named: "timelapse-icon.png")
			}
			else {
				typeIcon.image = UIImage(named: "video-icon.png")
			}
		}
		else if asset.mediaType == .Image {
			if asset.mediaSubtypes == .PhotoPanorama {
				typeIcon.image = UIImage(named: "panorama-icon.png")
			}
		}
		
		cachingImageManager.requestImageForAsset(asset, targetSize: assetGridThumbnailSize, contentMode: PHImageContentMode.AspectFill, options: nil, resultHandler: { (image: UIImage!, info :[NSObject : AnyObject]!) -> Void in
			if cell.tag == currentTag {
				thumbnail.image = image
			}
		})
		
		return cell
	}
	
	// MARK: UICollectionViewDelegateFlowLayout
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		let itemCount: CGFloat = UIDevice.currentDevice().userInterfaceIdiom == .Phone ? 4 : 8
		let a = (self.view.frame.size.width - itemCount * 1 - 2 * 2) / itemCount
		return CGSizeMake(a, a)
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
		return UIEdgeInsetsMake(2, 2, 2, 2)
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
		return 1
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
		return 1
	}
	
}