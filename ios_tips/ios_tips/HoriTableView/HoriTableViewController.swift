//
//  HoriTableViewController.swift
//  ios_tips
//
//  Created by roosky on 6/16/19.
//  Copyright © 2019 K W. All rights reserved.
//

import UIKit

class HoriTableViewController: UIViewController {
    weak var horiView: HoriTableView?
    
    override func loadView() {
        super.loadView()
        let hv = HoriTableView(frame: self.view.bounds)
        self.view.addSubview(hv)
        hv.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hv.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            hv.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            hv.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            hv.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5)
        ])
        hv.dataSource = self
        self.horiView = hv
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension HoriTableViewController: HoriViewDataSource {
    func horiView(_ horiView: HoriTableView, numOfColsInSection section: Int) -> Int {
        return 1000
    }
    
    func horiView(_ horiView: HoriTableView, cellForColAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Hello \(indexPath.row)"
        return cell
    }
}
