//
//  SlideLeftAnimationController.swift
//  CustomTransition
//
//  Created by Ada 2018 on 25/07/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit

//----- Classe auxiliar para direcionar uma animacao
class AnimationDirectionOptions {
    static let left = CGPoint(x: -1, y: 0)
    static let right = CGPoint(x: 1, y: 0)
    static let up = CGPoint(x: 0, y: 1)
    static let down = CGPoint(x: 0, y: -1)
}
//-----

//----- Classe responsavel pelas animacoes SLIDE
class SlideAnimationController: NSObject, TransitionProtocol {
    //  recebe a direcao da animacao
    var direction: CGPoint
    init(direction: CGPoint) {
        self.direction = direction
    }
    
    func animateTransition(from fromVC: UIView, to toVC: UIView) {
        guard let containerView = fromVC.superview else {
            return
        }
        
        //Move a view final para fora da tela na direcao oposta a animacao
        toVC.transform = CGAffineTransform(translationX: containerView.frame.size.width*self.direction.x, y: containerView.frame.size.width*self.direction.y)
        
        containerView.addSubview(fromVC)
        containerView.addSubview(toVC)
        
        let duration = 0.8
        
        // Traz a view final para a tela
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeCubic, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1, animations: {
                toVC.transform = CGAffineTransform(translationX: 0, y: 0)
            })
            
        }) { _ in
            
        }
    }
}
//-----
