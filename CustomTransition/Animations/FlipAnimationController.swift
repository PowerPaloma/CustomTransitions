//
//  FlipAnimationViewController.swift
//  CustomTransition
//
//  Created by Ada 2018 on 25/07/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit

//-----Classe responsavel pelas animacoes FLIP
class FlipAnimationController: NSObject, TransitionProtocol {
    var direction: CGPoint
    
    init(direction: CGPoint) {
        self.direction = direction
    }
    
    func animateTransition(from fromVC: UIView, to toVC: UIView) {
        guard let containerView = fromVC.superview else {
            return
        }
        
        // Rotaciona a view final escondendo-a dentro da tela
        toVC.layer.transform = CATransform3DMakeRotation(90.degreesToRadians, self.direction.y, -self.direction.x, 0)
        
        containerView.addSubview(toVC)
        containerView.addSubview(fromVC)
        
        let duration = 1.0
        
        // Realiza a animacao
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeCubic, animations: {
            
            //Rotaciona a view inicial para ficar na mesma posicao da final
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                fromVC.layer.transform = CATransform3DMakeRotation(90.degreesToRadians, self.direction.y, -self.direction.x, 0)
            })
            
            //---Revela a view final com efeito de suavizacao
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.35, animations: {
                toVC.layer.transform = CATransform3DMakeRotation(-15.degreesToRadians, self.direction.y, -self.direction.x, 0)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.85, relativeDuration: 0.1, animations: {
                toVC.layer.transform = CATransform3DMakeRotation(8.degreesToRadians, self.direction.y, -self.direction.x, 0)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.95, relativeDuration: 0.05, animations: {
                toVC.layer.transform = CATransform3DIdentity
            })
            //----
            
        }) { _ in
            // Retoma ao estado inicial da view
            fromVC.superview?.sendSubview(toBack: fromVC)
            fromVC.layer.transform = CATransform3DIdentity
        }
    }
}
