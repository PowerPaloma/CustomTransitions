//
//  Transition.swift
//  CustomTransition
//
//  Created by Ada 2018 on 24/07/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import Foundation
import UIKit

// Classe modelo para a tableView
class Transition {
    var nome: String
    var transition: TransitionProtocol
    var image: UIImage
    
    init(nome: String, transition: TransitionProtocol, image: UIImage) {
        self.nome = nome
        self.transition = transition
        self.image = image
    }
}

//Protocolo que toda classe precisa para ser uma classe de transicao
protocol TransitionProtocol {
    //Realiza a animacao entre duas views
    func animateTransition(from fromVC: UIView, to toVC: UIView)
}
