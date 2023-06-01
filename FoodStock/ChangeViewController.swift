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
    @IBAction func save (_ tableView: UITableView, cellForRowAt indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath)as! ChangeTableViewCell
        var nowIndexPathDictionary = foodArray[indexPath.row]
        nowIndexPathDictionary["num"] = cell.numTextField.text
        foodArray[indexPath.row] = nowIndexPathDictionary
        saveData.set(foodArray, forKey: "FOOD")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            as! ChangeTableViewCell
        
        let nowIndexPathDictionary = foodArray[indexPath.row]
        
        cell.foodLabel.text = nowIndexPathDictionary["food"]
        cell.preLabel.text = nowIndexPathDictionary["num"]
        
        return cell
    }

}

//extension ChangeViewController: UITableViewDelegate{
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//
//    }
//}
//
//extension ChangeViewController: UITableViewDataSource{
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return foodArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//            as! ChangeTableViewCell
//
//        let nowIndexPathDictionary = foodArray[indexPath.row]
//
//        cell.foodLabel.text = nowIndexPathDictionary["food"]
//        cell.preLabel.text = nowIndexPathDictionary["num"]
//
//        return cell
//    }
//}
