//
//  ViewController.swift
//  EHTags
//
//  Created by Eric Ho on 23/10/2016.
//  Copyright © 2016 Eric Ho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tagsView:EHTagsView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let words = ["hello", "Happy Day", "HoHoHo Word Word Word","cool","Chicken soup taste", "persistent storage", "solution to", "handle this", "aspect", "Chicken soup tsoup tastup tast","Chicken sooup tast","Chicken ast","Chickenp tastChist","Chict","Chickt", "Application. I applied", "through a recruiter. The process", "took 2 weeks", "Application.", "I applied", "through", "a", "recruiter.", "The process", "took 2 weeks"]
        //self.tagsView = EHTagsView()
        self.tagsView.setup(self.tagsView.bounds.width, words: words)
        self.tagsView.delegate = self
        print("Estimate tagViewHeight DDD = \(self.tagsView.estimateTagsViewHeight(tagsView.bounds.width))")
        self.view.setNeedsLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        self.tagsView?.setNeedsDisplay()
        print("Estimate tagViewHeight = \(self.tagsView.estimateTagsViewHeight(size.width))")
    }
}

extension ViewController: EHTagsViewDelegate {
    func didPressTagButton(tagButton: UIButton) {
        print("Button Press: \(tagButton.titleLabel?.text)")
    }
}
