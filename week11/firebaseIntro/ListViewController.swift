//
//  ListViewController.swift
//  firebaseIntro
//
//  Created by admin on 06/03/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var head: UITextField!
    
    @IBOutlet weak var body: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        cloudStorage.startListener(tableView: tableView)
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        print("viewdidload")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        print("viewwillappear")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cloudStorage.getListSize()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.title.text = cloudStorage.getNoteAt(index: indexPath.row).head
        cell.body.text = cloudStorage.getNoteAt(index: indexPath.row).body
        print("before cell return")
        return cell
    }
    
    
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        if let head = head.text{
            if let body = body.text{
                cloudStorage.createNote(head: head, body: body)
            }
        }
    }
    
}
