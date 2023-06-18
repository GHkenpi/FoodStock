//
//  ChangeViewController.swift
//  FoodStock
//
//  Created by 中根健介 on 2023/06/01.
//

import UIKit

class ChangeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var foodArray: [Dictionary<String, String>] = []
    let saveData = UserDefaults.standard
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ChangeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
//        tableView.delegate = self
//        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if saveData.array(forKey: "FOOD") != nil {
            foodArray = saveData.array(forKey: "FOOD") as! [Dictionary<String, String>]
        }
        
        tableView.reloadData()
    }
    
    @IBAction private func addButton() {

            var textFieldOnAlert = UITextField()

            let alert = UIAlertController(title: "テキスト入力",
                                          message: nil,
                                          preferredStyle: .alert)
            alert.addTextField { textField in
                textFieldOnAlert = textField
                textFieldOnAlert.returnKeyType = .done
            }

        let doneAction = UIAlertAction(title: "決定", style: .default) { [self] _ in
                let foodDictionary = ["food": textFieldOnAlert.text!, "num": "0"]
                foodArray.append(foodDictionary)
                saveData.set(foodArray, forKey: "FOOD")
                tableView.reloadData()
            }

            let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)

            alert.addAction(doneAction)
            alert.addAction(cancelAction)
            present(alert, animated: true)
        }
    
    @IBAction func save (){
        for index in 0...foodArray.count-1 {
            let cell = tableView.cellForRow(at: [0,index]) as! ChangeTableViewCell
            if let numText = cell.numTextField.text, let num = Int(numText) {
                var nowIndexPathDictionary = foodArray[index]
                nowIndexPathDictionary["num"] = cell.numTextField.text
                foodArray[index] = nowIndexPathDictionary
            } else {
                let alert = UIAlertController(title: "定数入力漏れ", message: "すべての定数を入力してください", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true, completion: nil)
                return
            }
//            var nowIndexPathDictionary = foodArray[index]
//            nowIndexPathDictionary["num"] = cell.numTextField.text
//            foodArray[index] = nowIndexPathDictionary
        }
        saveData.set(foodArray, forKey: "FOOD")
        let alertController = UIAlertController(title: "保存完了", message: "定数が保存されました", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{(action: UIAlertAction!) in
                     DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                         self.dismiss(animated: true, completion: nil)
                    }
                   }
                )
                  alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
    }
    @IBAction func cancel (){
        self.dismiss(animated: true, completion: nil)
    }
//    @IBAction func save (_ tableView: UITableView, cellForRowAt indexPath: IndexPath){
//        var cell = tableView.cellForRow(at: indexPath)as! ChangeTableViewCell
//        var nowIndexPathDictionary = foodArray[indexPath.row]
//        nowIndexPathDictionary["num"] = cell.numTextField.text
//        foodArray[indexPath.row] = nowIndexPathDictionary
//        saveData.set(foodArray, forKey: "FOOD")
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            as! ChangeTableViewCell
        
        let nowIndexPathDictionary = foodArray[indexPath.row]
        
        cell.foodLabel.text = nowIndexPathDictionary["food"]
        cell.preLabel.text = "現在の定数：" + String(nowIndexPathDictionary["num"] ?? "0")
        
        return cell
    }

}
