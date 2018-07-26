//
//  StackAnimationController.swift
//  CustomTransition
//
//  Created by Ada 2018 on 24/07/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit

//----- Extensoes para conversao de graus em radianos e vice-versa
extension BinaryInteger {
    var degreesToRadians: CGFloat { return CGFloat(Int(self)) * .pi / 180 }
}

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
//-----

//---- Classe responsavel pela animacao folha 1
class StackAnimationController: NSObject, TransitionProtocol {
    
    // Angulo de inclinacao da view superior
    private let angle: CGFloat
    
    init(rotationAngle: CGFloat) {
        self.angle = rotationAngle.degreesToRadians
    }
    
    // implementacao do TransitionProtocol
    func animateTransition(from fromVC: UIView, to toVC: UIView) {
        // Cria um container de transicao e adiciona as views envolvidas
        guard let containerView = fromVC.superview else {
            return
        }
        
        containerView.addSubview(toVC)
        containerView.addSubview(fromVC)
        
        let duration = 1.5
        
        // inicia a animacao
        UIView.animateKeyframes(withDuration: duration/2.0, delay: 0, options: .calculationModeCubic, animations: {
            
            // escala o tamanhao das views
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2, animations: {
                fromVC.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                toVC.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
            //move a view inicial e rotaciona para fora
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8, animations: {
                fromVC.transform = CGAffineTransform(translationX: -containerView.frame.size.width*1.1, y: 0).rotated(by: self.angle)
            })
            
        }) { _ in  // animacao encadeada
           
            //Traz a view final para cima
            toVC.superview?.bringSubview(toFront: toVC)
            
            // move a view inicial pra posicao de origem e escala a view final para o tamanho da tela
            UIView.animateKeyframes(withDuration: duration/2.0, delay: 0, options: .calculationModeCubic, animations: {
                
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.8, animations: {
                    fromVC.transform = CGAffineTransform(translationX: 0, y: 0).scaledBy(x: 0.8, y: 0.8)
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
                    toVC.transform = CGAffineTransform(scaleX: 1, y: 1)
                })
                
            }) { _ in
                // retomando ao tamanho original da view 
                fromVC.layer.transform = CATransform3DIdentity

            }
        }
    }
    

}
