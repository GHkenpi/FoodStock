//
//  ListViewController.swift
//  FoodStock
//
//  Created by 中根健介 on 2023/06/03.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var orderArray: [Dictionary<String, String>] = []
    let saveData = UserDefaults.standard
    
    @IBOutlet weak var Picker: UIDatePicker!
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if saveData.array(forKey: String(getCurrentDate())) != nil {
            orderArray = saveData.array(forKey: String(getCurrentDate())) as! [Dictionary<String, String>]
            print("save")
        }
        Label.text = (getCurrentDate())
        tableView.reloadData()
    }
    
    @IBAction func GetDate(_ sender: Any) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"

            // UIDatePickerから日付を取得
            let selectedDate = Picker.date

            // DateFormatterを使用して日付を指定の形式の文字列に変換
            let dateString = dateFormatter.string(from: selectedDate)
            Label.text = dateString
            if saveData.array(forKey: dateString) != nil {
               orderArray = saveData.array(forKey: dateString) as! [Dictionary<String, String>]
               print("save")
               tableView.reloadData()
            } else{
                orderArray = []
                var nowOrderIndexPath = ["food":"-","num":"-"]
                orderArray.append(nowOrderIndexPath)
                print("発注履歴なし")
                tableView.reloadData()
            }
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            as! OrderTableViewCell
        print("dotable")

        let nowIndexPathDictionary = orderArray[indexPath.row]
        
        cell.foodLabel.text = nowIndexPathDictionary["food"]
        cell.numLabel.text = nowIndexPathDictionary["num"]
        
        return cell
    }
    
    func getCurrentDate() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: Date())
        }
}
