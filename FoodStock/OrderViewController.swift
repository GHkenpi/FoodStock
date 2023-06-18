//
//  OrderViewController.swift
//  FoodStock
//
//  Created by 中根健介 on 2023/06/03.
//

import UIKit

class OrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var orderArray: [Dictionary<String, String>] = []
    let saveData = UserDefaults.standard
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if saveData.array(forKey: String(getCurrentDate())) != nil {
            orderArray = saveData.array(forKey: String(getCurrentDate())) as! [Dictionary<String, String>]
            print("save")
        }
//        if recordData.array(forKey: "RECORD") != nil {
//            let orderdata = getOrderData(for: getCurrentDate())
//            orderArray = orderdata!["foods"] as! [Dictionary<String, String>]
//            print("dotable")
//        }
        tableView.reloadData()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
