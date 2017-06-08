//
//  ViewController.swift
//  CSV Example
//
//  Created by Justin Doan on 6/7/17.
//  Copyright © 2017 Justin Doan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Declare the two textFields
    @IBOutlet var tf1: UITextField!
    @IBOutlet var tf2: UITextField!
    
    //Declare the table
    @IBOutlet var tableView: UITableView!
    
    //Create an item called Row with set properties called Column1 and Column2
    struct Row {
        var column1: String
        var column2: String
    }
    
    //An empty array of Row items
    var rows: [Row] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func addRow(_ sender: Any) {
        //Pull text from textFields
        if let c1 = tf1.text, let c2 = tf2.text {
            //Create new row item
            let newRow = Row(column1: c1, column2: c2)
            
            //Add it to the array
            rows.append(newRow)
            
            //Reload the tablewView
            tableView.reloadData()
        }
    }
    
    @IBAction func export(_ sender: Any) {
        //Create a file name
        let fileName = "FileName.csv"
        
        //Give it a place in the directory
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        
        //This string will be the column names with commas to separate them. Add "\n" to move to the next line
        var csvText = "Column 1,Column 2\n"
        
        for row in rows {
            //For each row, ad a new string of text with a comma. Add "\n" to move to the next line
            csvText.append("\(row.column1),\(row.column2)\n")
        }
        
        do {
            //puts file in the path
            try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
            
            //Displays export options
            let vc = UIActivityViewController(activityItems: [path!], applicationActivities: [])
            present(vc, animated: true, completion: nil)
            
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        let row = rows[indexPath.row]
        
        cell.textLabel?.text = row.column1
        cell.detailTextLabel?.text = row.column2
        
        return cell
    }
    
}

