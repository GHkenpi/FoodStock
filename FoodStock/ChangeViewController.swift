//
//  ChangeViewController.swift
//  FoodStock
//
//  Created by 中根健介 on 2023/06/01.
//

import UIKit

class ChangeViewController: UIViewController {
    
    var foodArray: [Dictionary<String, String>] = []
    let saveData = UserDefaults.standard
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
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
            }

            let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)

            alert.addAction(doneAction)
            alert.addAction(cancelAction)
            present(alert, animated: true)
        }
    @IBAction func save(){
        
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

extension ChangeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("you tapped me!")
    }
}

extension ChangeViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            as! ChangeTableViewCell
        
        var nowIndexPathDictionary = foodArray[indexPath.row]
        
        cell.foodLabel.text = nowIndexPathDictionary["food"]
        cell.preLabel.text = nowIndexPathDictionary["num"]
        func cellsave(){
            nowIndexPathDictionary["num"] = String(numTextField.text)
        }
        
        return cell
    }
}
