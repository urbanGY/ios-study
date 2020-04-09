//
//  ViewController.swift
//  Assignment5
//
//  Created by 김현석 on 2020/04/09.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var major: UITextField!
    @IBOutlet weak var grade: UITextField!
    
    @IBOutlet weak var saveName: UILabel!
    @IBOutlet weak var saveAge: UILabel!
    @IBOutlet weak var saveMajor: UILabel!
    @IBOutlet weak var saveGrade: UILabel!

    
    @IBAction func restoreBtn(_ sender: UIButton) {
        saveName.text = UserDefaults.standard.string(forKey: "name")
        saveAge.text = UserDefaults.standard.string(forKey: "age")
        saveMajor.text = UserDefaults.standard.string(forKey: "major")
        saveGrade.text = UserDefaults.standard.string(forKey: "grade")
    }
    
    @IBAction func store(_ sender: UIButton) {
        UserDefaults.standard.set(name.text!, forKey: "name")
        UserDefaults.standard.set(age.text!, forKey: "age")
        UserDefaults.standard.set(major.text!, forKey: "major")
        UserDefaults.standard.set(grade.text!, forKey: "grade")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

