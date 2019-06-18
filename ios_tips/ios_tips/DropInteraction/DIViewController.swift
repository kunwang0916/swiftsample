//
//  DIViewController.swift
//  ios_tips
//
//  Created by roosky on 6/18/19.
//  Copyright © 2019 K W. All rights reserved.
//

import UIKit

class DIViewController: UIViewController {
    weak var fileView: UIImageView!
    weak var trashCanView: UIImageView!
    var isDragingFileView = true
    
    override func loadView() {
        super.loadView()
        initSubViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        let di = UIDragInteraction(delegate: self)
        di.isEnabled = true
        self.view.addInteraction(di)
        
        let dropI = UIDropInteraction(delegate: self)
        self.view.addInteraction(dropI)
    }
    
    private func initSubViews() {
        let tv = UIImageView(image: UIImage(named:"trash_icon"))
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isUserInteractionEnabled = true
        self.view.addSubview(tv)
        NSLayoutConstraint.activate([
            tv.widthAnchor.constraint(equalToConstant: 100),
            tv.heightAnchor.constraint(equalToConstant: 100),
            tv.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            tv.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40)
        ])
        
        self.trashCanView = tv
        
        let fv = UIImageView(image: UIImage(named:"file_icon"))
        fv.translatesAutoresizingMaskIntoConstraints = false
        fv.isUserInteractionEnabled = true
        self.view.addSubview(fv)
        NSLayoutConstraint.activate([
            fv.widthAnchor.constraint(equalToConstant: 100),
            fv.heightAnchor.constraint(equalToConstant: 100),
            fv.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            fv.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        self.fileView = fv
        self.fileView.isUserInteractionEnabled = true
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


extension DIViewController: UIDragInteractionDelegate {
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        guard let view = self.view.hitTest(session.location(in: self.view), with: nil) as? UIImageView else {
            return []
        }
        guard let img = view.image else {
            return []
        }
        
        let item = UIDragItem(itemProvider: NSItemProvider(object: img))
        item.localObject = view
        return [item]
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, willAnimateLiftWith animator: UIDragAnimating, session: UIDragSession) {
        for it in session.items {
            if let tv = it.localObject as? UIView {
                tv.isHidden = true
            }
        }
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, previewForLifting item: UIDragItem, session: UIDragSession) -> UITargetedDragPreview? {
        return UITargetedDragPreview(view: item.localObject as! UIImageView)
    }
}

extension DIViewController: UIDropInteractionDelegate {
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .move)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        if self.trashCanView.frame.contains(session.location(in: self.view)) {
            print("delete")
        } else {
            print("reset")
            for item in session.items {
                if let tv = item.localObject as? UIView {
                    tv.isHidden = false
                }
            }
        }
    }
}
