//
//  ViewController.swift
//  Realm_Sample
//
//  Created by AtsushiSaito on 2018/04/08.
//  Copyright © 2018年 AtsushiSaito. All rights reserved.
//

import UIKit
import RealmSwift

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("読み込み時のデータ数:", LabMembers.count)
        return LabMembers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ViewCell.self), for: indexPath) as! ViewCell
        cell.Name.text = LabMembers[indexPath.row].name
        cell.Old.text = String(describing: LabMembers[indexPath.row].old)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        EditTextAlert(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm.write({
                realm.delete(LabMembers[indexPath.row])
                self.DataTable.deleteRows(at: [indexPath], with: .automatic)
            })
        }
    }
}

let realm = try! Realm()
let LabMembers = realm.objects(LabMember.self)

class ViewController: UIViewController {
    
    var DataTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "RealmSwift Sample"
        print("起動時のデータ数:", LabMembers.count)
        
        let AddButton = UIBarButtonItem(barButtonSystemItem : .add, target: self, action: #selector(self.InputTextAlert(sender:)))
        self.navigationItem.leftBarButtonItem = AddButton
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        self.DataTable = UITableView()
        self.DataTable.frame = self.view.frame
        self.DataTable.register(ViewCell.self, forCellReuseIdentifier: NSStringFromClass(ViewCell.self))
        
        self.DataTable.rowHeight = 120
        
        self.DataTable.delegate = self
        self.DataTable.dataSource = self
        self.view.addSubview(self.DataTable)
    }
    
    @objc func EditTextAlert(at: Int) {
        let alert = UIAlertController(title: "メンバーの編集", message: "メンバーの情報を入力してください", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            if let textFields = alert.textFields {
                if textFields[0].text != nil && textFields[1].text != nil {
                    let member = LabMembers[at]
                    try! realm.write {
                        member.name = textFields[0].text!
                        member.old = Int32(textFields[1].text!)!
                    }
                    DispatchQueue.main.async {
                        self.DataTable.reloadData()
                    }
                }
            }
        })
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        alert.addTextField(configurationHandler: {(textField_name: UITextField!) -> Void in
            textField_name.placeholder = LabMembers[at].name
        })
        
        alert.addTextField(configurationHandler: {(textField_old: UITextField!) -> Void in
            textField_old.placeholder = String(describing: LabMembers[at].old)
        })
        
        alert.view.setNeedsLayout() // シミュレータのエラー対策
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func InputTextAlert(sender: Any) {
        let alert = UIAlertController(title: "メンバーの追加", message: "メンバーの情報を入力してください", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            if let textFields = alert.textFields {
                if textFields[0].text != nil && textFields[1].text != nil {
                    let member = LabMember()
                    member.name = textFields[0].text!
                    member.old = Int32(textFields[1].text!)!
                    try! realm.write {
                        realm.add(member)
                    }
                    DispatchQueue.main.async {
                        self.DataTable.reloadData()
                    }
                }
            }
        })
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        alert.addTextField(configurationHandler: {(textField_name: UITextField!) -> Void in
            textField_name.placeholder = "名前"
        })
        
        alert.addTextField(configurationHandler: {(textField_old: UITextField!) -> Void in
            textField_old.placeholder = "年齢"
        })
        
        alert.view.setNeedsLayout() // シミュレータのエラー対策
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

