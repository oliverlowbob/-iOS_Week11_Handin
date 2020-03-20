//
//  ViewController.swift
//  firebaseIntro
//
//  Created by admin on 28/02/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var rowNumber = 0
    @IBOutlet weak var headline: UITextView!
    @IBOutlet weak var body: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //use rownumber to get the right note object
        let note = cloudStorage.getNoteAt(index: rowNumber)
        headline.text = note.head
        body.text = note.body
        if note.imageid != "empty"{
            cloudStorage.downloadImage(name: note.imageid, vc: self)
        }
        //imageView.image = note.imageid
        //cloudStorage.readNotes()
        
    }
    

    @IBOutlet weak var backClicked: UINavigationItem!
    
    

    // cloudStorage.createNote(head: headline.text!, body: body.text!)

    
    @IBAction func saveBtnPressed(_ sender: Any) {
        cloudStorage.updateNote(index: 0, head: headline.text!, body: body.text!)
    }
    

}
