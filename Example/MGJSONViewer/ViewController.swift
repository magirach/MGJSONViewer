//
//  ViewController.swift
//  MGJSONViewer
//
//  Created by Moinuddin Girach on 08/15/2022.
//  Copyright (c) 2022 Moinuddin Girach. All rights reserved.
//

import UIKit
import MGJSONViewer

class ViewController: UIViewController {

    var obj: Any?
    let tbl: MGJSONViewer = {
        let tbl = MGJSONViewer()
        tbl.translatesAutoresizingMaskIntoConstraints = false
        return tbl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tbl)
        tbl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tbl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tbl.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tbl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tbl.loadData(fileName: "json",
                     ext: "txt")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

