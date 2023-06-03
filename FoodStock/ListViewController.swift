//
//  ListViewController.swift
//  FoodStock
//
//  Created by 中根健介 on 2023/06/03.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var recordArray: [[String: Any]] = []
    var orderArray: [Dictionary<String, String>] = []
    let recordData = UserDefaults.standard
    
    @IBOutlet weak var Picker: UIDatePicker!
    @IBOutlet weak var Label: UILabel!
    var orderdata1 = ["food":"じゃがいも","num":"3"]
    var orderdata2 = ["food":"にんじん","num":"2"]
    var orderdata3 = ["food":"かぼちゃ","num":"1"]
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        orderArray.append(orderdata1)
        orderArray.append(orderdata2)
        orderArray.append(orderdata3)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if recordData.array(forKey: "RECORD") != nil {
            recordArray = recordData.array(forKey: "RECORD") as! [[String: Any]]
            print("save")
        }
        if recordData.array(forKey: "RECORD") != nil {
            let orderdata = getOrderData(for: getCurrentDate())
            orderArray = orderdata!["foods"] as! [Dictionary<String, String>]
            print("dotable")
        }
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
            if recordData.array(forKey: "RECORD") != nil {
            let orderdata = getOrderData(for: dateString)
                orderArray = orderdata!["foods"] as! [Dictionary<String, String>]
                print("dotable")
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
    
    func getOrderData(for date: String) -> [String: Any]? {
            return orderArray.first { $0["date"] as? String == date }
        }
    
    func getCurrentDate() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: Date())
        }
}
