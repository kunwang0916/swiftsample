//
//  DragDropViewController.swift
//  ios_tips
//
//  Created by roosky on 6/17/19.
//  Copyright © 2019 K W. All rights reserved.
//

import UIKit

class DragDropViewController: UIViewController {
    weak var fileView: UIView?
    weak var trashCanView: UIView?
    var isDragingFileView = true
    
    override func loadView() {
        super.loadView()
        initSubViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    private func initSubViews() {
        let tv = UIView(frame: .zero)
        tv.backgroundColor = .red
        tv.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tv)
        NSLayoutConstraint.activate([
            tv.widthAnchor.constraint(equalToConstant: 100),
            tv.heightAnchor.constraint(equalToConstant: 100),
            tv.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            tv.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40)
            ])
        
        self.trashCanView = tv
        
        let fv = UIView(frame: .zero)
        fv.backgroundColor = .blue
        fv.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(fv)
        NSLayoutConstraint.activate([
            fv.widthAnchor.constraint(equalToConstant: 100),
            fv.heightAnchor.constraint(equalToConstant: 100),
            fv.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            fv.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        self.fileView = fv

        let pg = UIPanGestureRecognizer(target: self, action: #selector(self.onPanAction(_ :)))
        self.view.addGestureRecognizer(pg)
    }
    
    @objc func onPanAction(_ pg: UIPanGestureRecognizer) {
        let pgPoint = pg.location(in: self.view)
        switch pg.state {
        case .began:
            self.isDragingFileView = self.fileView?.frame.contains(pgPoint) ?? false
        case .changed:
            if self.isDragingFileView {
                self.fileView?.center = pgPoint
            }
            break
        default:
            self.dealWithEndOfPan(pg)
        }
    }
    
    func dealWithEndOfPan(_ pg: UIPanGestureRecognizer) {
        if pg.state == .ended {
            guard let fileFrame = self.fileView?.frame else {
                return
            }
            let onTranshCan = self.trashCanView?.frame.intersects(fileFrame) ?? false
            // released on trash can
            if onTranshCan {
                print("delete")
                self.fileView?.isHidden = true
            }
        }
        // reset
        self.isDragingFileView = false
        self.fileView?.center = self.view.center
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
