//
//  UIImageCacheViewController.swift
//  ios_tips
//
//  Created by roosky on 6/23/19.
//  Copyright © 2019 K W. All rights reserved.
//

import UIKit

class UIImageCacheViewController: UIViewController {
    weak var imageView: UIImageView?
    
    override func loadView() {
        super.loadView()
        let iv = UIImageView(frame: .zero)
        iv.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(iv)
        NSLayoutConstraint.activate([
            iv.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            iv.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            iv.widthAnchor.constraint(equalToConstant: 100.0),
            iv.heightAnchor.constraint(equalToConstant: 100.0)
        ]);
        
        self.imageView = iv
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let url = URL(string: "https://www.petmd.com/sites/default/files/Acute-Dog-Diarrhea-47066074.jpg") {
            self.imageView?.wk_setImage(with: url)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
