//
//  ViewController.swift
//  calculator
//
//  Created by 김현석 on 25/03/2020.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
    }

    @IBOutlet weak var input1: UITextField!
    @IBOutlet weak var input2: UITextField!
    @IBOutlet weak var output: UILabel!
    
    @IBAction func ClickPlusButton(_ sender: UIButton) {
        let input1Int: Int! = Int(input1.text!)
        let input2Int: Int! = Int(input2.text!)
        let result:String! = "\(input1Int!) + \(input2Int!) = \(input1Int + input2Int)"
        output.text = result
        output.textAlignment = .center
    }
    
    @IBAction func ClickMinusButton(_ sender: UIButton) {
        let input1Int: Int! = Int(input1.text!)
        let input2Int: Int! = Int(input2.text!)
        let result:String! = "\(input1Int!) - \(input2Int!) = \(input1Int - input2Int)"
        output.text = result
        output.textAlignment = .center
    }
    
    @IBAction func ClickMultiplyButton(_ sender: UIButton) {
        let input1Int: Int! = Int(input1.text!)
        let input2Int: Int! = Int(input2.text!)
        let result:String! = "\(input1Int!) * \(input2Int!) = \(input1Int * input2Int)"
        output.text = result
        output.textAlignment = .center
    }
    
    @IBAction func ClickDivideButton(_ sender: UIButton) {
        let input1Int: Int! = Int(input1.text!)
        let input2Int: Int! = Int(input2.text!)
        let result:String! = "\(input1Int!) / \(input2Int!) = \(input1Int / input2Int)"
        output.text = result
        output.textAlignment = .center
    }
    
}

