//
//  ViewController.swift
//  AppLocker
//
//  Created by Blue Sky on 12/12/2017.
//  Copyright © 2017 Blue Sky. All rights reserved.
//

import UIKit

class AppListViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	var appListDataSource: AppListDataSource = AppListDataSource()
	var searchController = UISearchController()
	
	var backgroundTaskIdentifier: UIBackgroundTaskIdentifier?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.dataSource = appListDataSource
		configureSearchController()
		
		//				var timer: Timer!
		//				timer = Timer.scheduledTimer(
		//						timeInterval: 1.0, //in seconds
		//						target: self, //where you'll find the selector (next argument)
		//						selector: #selector(self.Tick), //MyClass is the current class
		//						userInfo: nil, //no idea what this is, Apple, help?
		//						repeats: true) //keep going!
		backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(
			expirationHandler: {UIApplication.shared.endBackgroundTask(self.backgroundTaskIdentifier!)})
		_ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.Tick), userInfo: nil, repeats: true)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// MARK: - SearchController
	
	func configureSearchController() {
		searchController = ({
			let controller = UISearchController(searchResultsController: nil)
			
			controller.searchBar.scopeButtonTitles = ["All", "System", "User"]
			controller.searchBar.showsBookmarkButton = true
			controller.searchBar.delegate = appListDataSource
			
			controller.searchResultsUpdater = appListDataSource
			controller.delegate = appListDataSource
			appListDataSource.tableView = tableView
			controller.hidesNavigationBarDuringPresentation = false
			controller.dimsBackgroundDuringPresentation = false
			controller.searchBar.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44)
			tableView.tableHeaderView = controller.searchBar
			definesPresentationContext = true
			
			return controller
		})()
	}
	
	func pin(_ mode: LockerMode) {
		var config = LockerConfig()
		config.image = UIImage(named: "face")!
		config.title = "ASAN"
		
		AppLocker.present(with: mode, and: config)
	}
	
	@objc private func Tick() {
//		pin(.validate)
		print("scheduled service")
	}
}

