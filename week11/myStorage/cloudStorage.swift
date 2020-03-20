//
//  cloudStorage.swift
//  firebaseIntro
//
//  Created by admin on 28/02/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

class cloudStorage {
    
    private static var list = [Note]()
    private static let db = Firestore.firestore()
    private static let notes = "notes"
    private static let storage = Storage.storage()
    

    static func startListener(tableView:UITableView){
        print("starting listener")
        db.collection(notes).addSnapshotListener { (snap, error) in
            if error == nil {
                self.list.removeAll() // clears list before adding new items
                for note in snap!.documents{
                    let map = note.data()
                    let head = map["head"] as! String
                    let body = map["body"] as! String
                    let imageid = map["imageid"] as? String ?? "empty"
                    let newNote = Note(id: note.documentID, head: head, body: body, imageid: imageid)
                    self.list.append(newNote)
                }
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
        }
    }
    
    //Read func
    static func readNotes(){
        db.collection(notes).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("error getting doc")
            } else {
                for document in querySnapshot!.documents {
                    print(document.data())
                }
            }
       
            }
    }

    static func getListSize() -> Int{
        return list.count
    }
    
    static func getNoteAt(index:Int) -> Note {
        return list[index]
    }
    
 
    
    static func createNote(head:String, body:String){
        let docRef = db.collection(notes).document()
        var map = [String:String]()
        map["head"] = head
        map["body"] = body
        docRef.setData(map)
    }
    
    static func updateNote(index:Int, head:String, body:String){
        let note = list[index]
        let docRef = db.collection(notes).document(note.id)
        var map = [String:String]()
        map["head"] = head
        map["body"] = body
        map["imageid"] = note.imageid
        docRef.setData(map)
        
    }
    
    static func deleteNote(id:String){
        let docRef = db.collection(notes).document(id)
        docRef.delete()
    }
    
}
