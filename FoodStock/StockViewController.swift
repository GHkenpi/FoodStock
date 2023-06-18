//
//  StockViewController.swift
//  FoodStock
//
//  Created by 中根健介 on 2023/06/03.
//

import UIKit

class StockViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var foodArray: [Dictionary<String, String>] = []
//    var orderArray: [Dictionary<String, String>] = []
    let saveData = UserDefaults.standard
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "StockTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        print(getCurrentDate())
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if saveData.array(forKey: "FOOD") != nil {
            foodArray = saveData.array(forKey: "FOOD") as! [Dictionary<String, String>]
        }
//        orderArray = []
//        for _ in 0...foodArray.count-1 {
//            let foodDictionary = ["food": "あ"]
//            orderArray.append(foodDictionary)
//        }
//        if saveData.array(forKey: String(getCurrentDate())) != nil {
//            orderArray = saveData.array(forKey: String(getCurrentDate())) as! [Dictionary<String, String>]
//            print("save")
//        }
//        if recordData.array(forKey: "RECORD") != nil {
//        let orderdata = getOrderData(for: getCurrentDate())
//            orderArray = orderdata!["foods"] as! [Dictionary<String, String>]
//            print("dotable")
//        }
//        for _ in 0...foodArray.count-1 {
//            let foodDictionary = ["food": "あ"]
//            orderArray.append(foodDictionary)
//        }
        tableView.reloadData()
    }
    
    
    
    @IBAction func save(){
//        if let recordData = UserDefaults.standard.array(forKey: "RECORD") as? [[String: Any]] {
//                        recordArray = savedArray
//                }
        var orderArray: [Dictionary<String, String>] = []
        for index in 0...foodArray.count-1 {
            let cell = tableView.cellForRow(at: [0,index]) as! StockTableViewCell
            if let numText = cell.numTextField.text, let num = Int(numText) {
                let nowIndexPathDictionary = foodArray[index]
                var nowOrderIndexPath = ["food":"","num":""]
                let order: Int = Int(nowIndexPathDictionary["num"]!)!
                let number: Int = num
                if number <= order {
                    nowOrderIndexPath["num"] = String(order - number)
                }else{
                    nowOrderIndexPath["num"] = "0"
                    print("do 0")
                }
                nowOrderIndexPath["food"] = nowIndexPathDictionary["food"]
                orderArray.append(nowOrderIndexPath)
                print("do")
            }else{
                let alert = UIAlertController(title: "定数入力漏れ", message: "すべての定数を入力してください", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true, completion: nil)
                return
            }
        }
        saveData.set(orderArray, forKey: String(getCurrentDate()))
        let alertController = UIAlertController(title: "保存完了", message: "定数が保存されました", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{(action: UIAlertAction!) in
                     DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                         self.performSegue(withIdentifier: "toOrderView", sender: nil)
                    }
                   }
                )
                  alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            as! StockTableViewCell
        let nowIndexPathDictionary = foodArray[indexPath.row]
//        var nowOrderIndexPath = orderArray[indexPath.row]
        cell.foodLabel.text = nowIndexPathDictionary["food"]
        cell.preLabel.text = "現在の定数：" + String(nowIndexPathDictionary["num"] ?? "0")
        
        return cell
    }
    
    func getCurrentDate() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: Date())
        }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UITextField {
    var textToInt: Int {
        let text = self.text
        let int = text
            .flatMap{Int($0)} ?? 0
        return int
    }
}

