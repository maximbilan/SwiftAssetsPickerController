//
//  RootListAssetsViewController.swift
//  SwiftAssetsPickerController
//
//  Created by Maxim Bilan on 6/5/15.
//  Copyright (c) 2015 Maxim Bilan. All rights reserved.
//

import UIKit

class RootListAssetsViewController: UITableViewController {
	
	private let reuseIdentifier = "FlickrCell"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Navigation bar
		navigationItem.title = "Photos"
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelAction")
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "doneAction")
		navigationItem.rightBarButtonItem?.enabled = false
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: UITableViewDataSource
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
		
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