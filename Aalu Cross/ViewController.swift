//
//  ViewController.swift
//  Aalu Cross
//
//  Created by Bikram Dangol on 7/29/16.
//  Copyright © 2016 AppCoders. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var activePlayer = 1
    var boardStatus = [0,0,0,
                       0,0,0,
                       0,0,0]
    var isGameOver = false
    let winningCombinations = [[0,1,2], [3,4,5], [6,7,8],
                              [0,3,6], [1,4,7], [2,5,8],
                              [0,4,8], [2,4,6]]

    @IBOutlet var winMessageLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        let currentPosition = sender.tag - 1
        if boardStatus[currentPosition] == 0 && !isGameOver
        {
            if activePlayer == 1
            {
                sender.setImage(UIImage(named: "nought.png"), for: [])
                boardStatus[currentPosition] = activePlayer
                activePlayer = 2
            }
            else
            {
                sender.setImage(UIImage(named: "cross.png"), for: [])
                boardStatus[currentPosition] = activePlayer
                activePlayer = 1
            }
            for winningCombination in winningCombinations
            {
                if boardStatus[winningCombination[0]] != 0 &&
                    boardStatus[winningCombination[0]] == boardStatus[winningCombination[1]] &&
                    boardStatus[winningCombination[1]] == boardStatus[winningCombination[2]]
                {
                    isGameOver = true
                    
                    if(boardStatus[winningCombination[0]] == 1)
                    {
                        winMessageLabel.text = "Noughts has won!"
                    }
                    else
                    {
                        winMessageLabel.text = "Crosses has won!"
                    }
                    winMessageLabel.isHidden = false
                    restartButton.isHidden = false
                    UIView.animate(withDuration: 1, animations: { 
                        self.moveMessageLabelAndButton(by: 500.0)
                    })
                    break
                }
            }
            if(!isGameOver)
            {
                var isDraw = true
                for value in boardStatus
                {
                    if value == 0
                    {
                        isDraw = false
                        break
                    }
                }
                if isDraw == true
                {
                    winMessageLabel.text = "It's Draw."
                    winMessageLabel.isHidden = false
                    restartButton.isHidden = false
                    UIView.animate(withDuration: 1, animations: {
                        self.moveMessageLabelAndButton(by: 500.0)
                    })
                }
            }
        }
    }
    
    @IBAction func restartButtonPressed(_ sender: UIButton) {
        activePlayer = 1
        boardStatus = [0,0,0,
                       0,0,0,
                       0,0,0]
        isGameOver = false
        winMessageLabel.isHidden = true
        restartButton.isHidden = true
        moveMessageLabelAndButton(by: -500.0)
        
        for i in 1...9
        {
            if let button = view.viewWithTag(i) as? UIButton
            {
                button.setImage(nil, for: [])
            }
        }
    }
    func moveMessageLabelAndButton(by pixel: CGFloat)
    {
        winMessageLabel.center.x = winMessageLabel.center.x + pixel
        restartButton.center.x = restartButton.center.x + pixel
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        winMessageLabel.isHidden = true
        restartButton.isHidden = true
        moveMessageLabelAndButton(by: -500.0)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

