//
//  TransitionsTableViewController.swift
//  CustomTransition
//
//  Created by Ada 2018 on 24/07/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit

var currentTransition = 0

class TransitionsTableViewController: UITableViewController {
    
    // Transicoes realizadas
    static let transitions = [
        Transition(nome: "Folha 1", transition: StackAnimationController(rotationAngle: 15), image: #imageLiteral(resourceName: "stack_image")),
        Transition(nome: "Slide Over Left", transition: SlideAnimationController(direction: AnimationDirectionOptions.left), image: #imageLiteral(resourceName: "stack_image")),
        Transition(nome: "Slide Over Right", transition: SlideAnimationController(direction: AnimationDirectionOptions.right), image: #imageLiteral(resourceName: "stack_image")),
        Transition(nome: "Slide Over Up", transition: SlideAnimationController(direction: AnimationDirectionOptions.up), image: #imageLiteral(resourceName: "stack_image")),
        Transition(nome: "Slide Over Down", transition: SlideAnimationController(direction: AnimationDirectionOptions.down), image: #imageLiteral(resourceName: "stack_image")),
        Transition(nome: "Flip Left", transition: FlipAnimationController(direction: AnimationDirectionOptions.left), image: #imageLiteral(resourceName: "stack_image")),
        Transition(nome: "Flip Right", transition: FlipAnimationController(direction: AnimationDirectionOptions.right), image: #imageLiteral(resourceName: "stack_image")),
        Transition(nome: "Flip Up", transition: FlipAnimationController(direction: AnimationDirectionOptions.up), image: #imageLiteral(resourceName: "stack_image")),
        Transition(nome: "Flip Down", transition: FlipAnimationController(direction: AnimationDirectionOptions.down), image: #imageLiteral(resourceName: "stack_image")),
        Transition(nome: "Slice", transition: MultiFlipAnimationController(direction: AnimationDirectionOptions.down, numberOfParts: 3), image: #imageLiteral(resourceName: "stack_image")),
        Transition(nome: "Slice 2", transition: MultiFlipAnimationController(direction: AnimationDirectionOptions.up, numberOfParts: 7), image: #imageLiteral(resourceName: "stack_image")),
        Transition(nome: "Curtain", transition: MultiFlipAnimationController(direction: AnimationDirectionOptions.left, numberOfParts: 5), image: #imageLiteral(resourceName: "stack_image")),
        Transition(nome: "Curtain 2", transition: MultiFlipAnimationController(direction: AnimationDirectionOptions.right, numberOfParts: 9), image: #imageLiteral(resourceName: "stack_image"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TransitionsTableViewController.transitions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transition", for: indexPath)
        cell.textLabel?.text = TransitionsTableViewController.transitions[indexPath.row].nome
        return cell
    }
    
    // Ao escolher uma celula da tableView realiza a transicao selecionada
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentTransition = indexPath.row
        guard let display = splitViewController?.viewControllers[1] as? ViewController else {
            return
        }
        display.doTransition()
    }


}
