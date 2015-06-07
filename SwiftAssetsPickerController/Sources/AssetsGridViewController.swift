//
//  AssetsGridViewController.swift
//  SwiftAssetsPickerController
//
//  Created by Maxim Bilan on 6/5/15.
//  Copyright (c) 2015 Maxim Bilan. All rights reserved.
//

import UIKit
import Photos

class AssetsGridViewController: UICollectionViewController {
	
	var collection: PHAssetCollection?
	private let reuseIdentifier = "AssetsGridCell"
	
	private var assetsFetchResult: PHFetchResult!
	
	override init(collectionViewLayout layout: UICollectionViewLayout) {
		super.init(collectionViewLayout: layout)
	}

	required init(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.itemSize = CGSizeMake(200, 140)
		flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
		
		collectionView?.collectionViewLayout = flowLayout
		collectionView?.backgroundColor = UIColor.whiteColor()
		collectionView?.registerClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: reuseIdentifier)
		
		assetsFetchResult = (collection == nil) ? PHAsset.fetchAssetsWithMediaType(.Image, options: nil) : PHAsset.fetchAssetsInAssetCollection(collection, options: nil)
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: UICollectionViewDelegate
	
	
	// MARK: UICollectionViewDataSource
	
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return assetsFetchResult.count
	}
	
	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
		//cell.backgroundColor = UIColor.blackColor()
		// Configure the cell
		
		let asset = assetsFetchResult[indexPath.row] as! PHAsset
		
		if let imageView = cell.viewWithTag(101) {
			
		}
		else {
			let imageView = UIImageView(frame: cell.frame)
			imageView.tag = 101
			PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: CGSizeMake(100, 100), contentMode: PHImageContentMode.AspectFill, options: nil, resultHandler: { (image: UIImage!, info: [NSObject : AnyObject]!) -> Void in
				imageView.image = image
			})
			cell.addSubview(imageView)
		}
		
		return cell
	}
	
}