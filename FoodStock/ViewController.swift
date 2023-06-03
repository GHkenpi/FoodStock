//
//  ViewController.swift
//  FoodStock
//
//  Created by 中根健介 on 2023/05/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        button1.layer.cornerRadius = 35
        button2.layer.cornerRadius = 35
        // Do any additional setup after loading the view.
    }
    
    @IBAction func change(sender: UIStoryboardSegue){
        
    }
    
    @IBAction func log(sender: UIStoryboardSegue){
        
    }
    
    @IBAction func orderButtonTapped(){
        let saveData = UserDefaults.standard
        if saveData.array(forKey: "FOOD") != nil {
            if saveData.array(forKey: "FOOD")!.count > 0 {
                performSegue(withIdentifier: "toStockView", sender: nil)
            }
        }else{
            let alert = UIAlertController (
                title: "食材未登録",
                message:"定数変更から食材を登録してください",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil
            ))
            
            self.present(alert, animated: true, completion: nil)
        }
    }


}

