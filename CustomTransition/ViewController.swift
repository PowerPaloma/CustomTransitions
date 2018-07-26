//
//  ViewController.swift
//  CustomTransition
//
//  Created by Ada 2018 on 24/07/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Outlets da view inicial e final
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageViewDestination: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func doTransition() {
        //Obtem a transicao selecionada na tableView e chama o animateTransition
        TransitionsTableViewController.transitions[currentTransition].transition.animateTransition(from: imageView, to: imageViewDestination)
        
        //Swap nas views para o novo estado delas
        let temp = imageView
        imageView = imageViewDestination
        imageViewDestination = temp
    }
}

