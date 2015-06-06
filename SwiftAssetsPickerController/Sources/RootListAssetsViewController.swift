//
//  RootListAssetsViewController.swift
//  SwiftAssetsPickerController
//
//  Created by Maxim Bilan on 6/5/15.
//  Copyright (c) 2015 Maxim Bilan. All rights reserved.
//

import UIKit
import Photos

class RootListAssetsViewController: UITableViewController {
	
	private var data: Array<PHObject>!
	private var activityIndicator: UIActivityIndicatorView!
	private let reuseIdentifier = "RootListAssetsCell"
	
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
		data = Array()
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(true)
		
		loadData()
	}
	
	deinit {
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: ---
	
	func loadData() {
		tableView.userInteractionEnabled = false
		activityIndicator.startAnimating()
		
		let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
		dispatch_async(dispatch_get_global_queue(priority, 0)) {
			
			NSThread.sleepForTimeInterval(5)
			
			dispatch_async(dispatch_get_main_queue()) {
				self.tableView.reloadData()
				self.activityIndicator.stopAnimating()
				self.tableView.userInteractionEnabled = true
			}
		}
	}
	
	// MARK: UITableViewDataSource
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return data.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
		
		cell.textLabel?.text = "Row #\(indexPath.row)"
		cell.detailTextLabel?.text = "Subtitle #\(indexPath.row)"
		return cell
	}
	
	// MARK: UITableViewDelegate
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		
		let assetsGrid = AssetsGridViewController(collectionViewLayout: UICollectionViewLayout())
		navigationController?.pushViewController(assetsGrid, animated: true)
	}
	
	// MARK: Navigation bar actions
	
	func cancelAction() {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	func doneAction() {
		
	}
	
}