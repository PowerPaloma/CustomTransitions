//
//  MultiFlipAnimationController.swift
//  CustomTransition
//
//  Created by Ada 2018 on 25/07/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit

// Classe responsavel pela animacao MULTIFLIP
class MultiFlipAnimationController: NSObject, TransitionProtocol {
    var direction: CGPoint
    var numberOfParts: Int // Define o numero de divisoes da view
    
    init(direction: CGPoint, numberOfParts: Int) {
        self.direction = direction
        self.numberOfParts = numberOfParts
    }
    
    func animateTransition(from fromVC: UIView, to toVC: UIView) {
        guard let containerView = fromVC.superview else {
            return
        }
        
        //Rotaciona a view inicial e a final para que so aparecam das divisoes
        fromVC.layer.transform = CATransform3DMakeRotation(90.degreesToRadians, self.direction.y, -self.direction.x, 0)
        toVC.layer.transform = CATransform3DMakeRotation(90.degreesToRadians, self.direction.y, -self.direction.x, 0)
        
        for piece in 0..<numberOfParts {
            
            // **Montando a Divisao da view inicial
            
            // Definindo o Rect da divisao dentro da view
            let sliceRect = CGRect(x: CGFloat(piece) * (containerView.frame.width / CGFloat(numberOfParts)), y: 0, width: containerView.frame.width / CGFloat(numberOfParts), height: containerView.frame.height)
            
            //-----Criando a copia do objeto imageView
            var data = NSKeyedArchiver.archivedData(withRootObject: fromVC)
            let sliceFrom: UIImageView = NSKeyedUnarchiver.unarchiveObject(with: data) as! UIImageView
            //-----
            
            // Obtendo o cgImage da UIImage
            guard let cgImageFrom = sliceFrom.image?.cgImage else {
                return
            }
            
            //Defeine o Rect da divisao dentro da imagem
            let sliceImageFrom = CGRect(x: CGFloat(piece) * (CGFloat(cgImageFrom.width) / CGFloat(numberOfParts)), y: 0, width: CGFloat(cgImageFrom.width) / CGFloat(numberOfParts), height: CGFloat(cgImageFrom.height))
            
            //Cortando a imagem da view inicial
            guard let cropImageFrom = sliceFrom.image?.cgImage?.cropping(to: sliceImageFrom) else {
                return
            }
            
            // Setando a imagem cortada para a divisao
            sliceFrom.image = UIImage(cgImage: cropImageFrom)
            // Estabelecendo o frame da divisao
            sliceFrom.frame = sliceRect
            //**
           
            // ** Montando a Divisao da view final
            
            data = NSKeyedArchiver.archivedData(withRootObject: toVC)
            let sliceTo: UIImageView = NSKeyedUnarchiver.unarchiveObject(with: data) as! UIImageView
            
            guard let cgImageTo = sliceTo.image?.cgImage else {
                return
            }
            
            let sliceImageTo = CGRect(x: CGFloat(piece) * (CGFloat(cgImageTo.width) / CGFloat(numberOfParts)), y: 0, width: CGFloat(cgImageTo.width) / CGFloat(numberOfParts), height: CGFloat(cgImageTo.height))
            guard let cropImageTo = sliceTo.image?.cgImage?.cropping(to: sliceImageTo) else {
                return
            }
            
            sliceTo.image = UIImage(cgImage: cropImageTo)
            sliceTo.frame = sliceRect
            sliceTo.backgroundColor = .clear
            //**
            
            sliceTo.layer.transform = CATransform3DMakeRotation(90.degreesToRadians, self.direction.y, -self.direction.x, 0)
            
            containerView.addSubview(sliceTo)
            containerView.addSubview(sliceFrom)
            
            let duration = 0.8 + 0.1 * Double(numberOfParts)
            
            // Realiza a animacao FLIP com delay para cada parte
            UIView.animateKeyframes(withDuration: duration, delay: 0.1*Double(piece), options: .calculationModeCubic, animations: {

                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                    sliceFrom.layer.transform = CATransform3DMakeRotation(90.degreesToRadians, self.direction.y, -self.direction.x, 0)
                })

                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.35, animations: {
                    sliceTo.layer.transform = CATransform3DMakeRotation(-15.degreesToRadians, self.direction.y, -self.direction.x, 0)
                })

                UIView.addKeyframe(withRelativeStartTime: 0.85, relativeDuration: 0.1, animations: {
                    sliceTo.layer.transform = CATransform3DMakeRotation(8.degreesToRadians, self.direction.y, -self.direction.x, 0)
                })

                UIView.addKeyframe(withRelativeStartTime: 0.95, relativeDuration: 0.05, animations: {
                    sliceTo.layer.transform = CATransform3DIdentity
                })

            }) { completed in
                // Removendo as divisoes
                sliceFrom.removeFromSuperview()
                sliceTo.removeFromSuperview()
                //Retornando ao estado original da view inicial
                fromVC.superview?.sendSubview(toBack: fromVC)
                fromVC.layer.transform = CATransform3DIdentity
                //exibe a view final
                toVC.layer.transform = CATransform3DIdentity
            }
        }
    }
}
