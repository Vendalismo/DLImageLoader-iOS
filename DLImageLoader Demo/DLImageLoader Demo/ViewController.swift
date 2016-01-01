//
//  ViewController.swift
//  DLImageLoader Demo
//
//  Created by Andrew Lunevich on 9/15/15.
//  Copyright © 2015 Andrew Lunevich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: DLImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let request = NSURLRequest(URL: NSURL(string: "http://lialka.net/images/home/summer.jpg")!)
        self.imageView.imageFromRequest(request)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}