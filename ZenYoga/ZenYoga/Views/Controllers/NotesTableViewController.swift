//
//  NotesTableViewController.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 22/11/2023.
//

import UIKit
import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class NotesTableViewController: UITableViewController {
    
    private var user: User!
    private var notes = [Note]()
    var ref: DatabaseReference!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentUser = Auth.auth().currentUser else { return }
        user = User(user: currentUser)
        ref = Database.database().reference(withPath: "users").child(user.uid).child("notes")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ref.observe(.value) { [weak self] snapshot in
            var notes = [Note]()
            for item in snapshot.children {
                guard let snapshot = item as? DataSnapshot,
                      let note = Note(snapshot: snapshot) else { return }
                notes.append(note)
            }
            self?.notes = notes
            self?.tableView.reloadData()
        }
    }
    

    @IBAction func addNewNoteAction(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "New note", message: "Add new note title", preferredStyle: .alert)
        alertController.addTextField()
        let save = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let self,
                  let textField = alertController.textFields?.first,
                  let text = textField.text else { return }
            let uid = user.uid
            let note = Note(title: text, userId: uid)
            let noteRef = ref.child(note.title.lowercased())
            noteRef.setValue(note.convertToDictionary())
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancel)
        alertController.addAction(save)
        present(alertController, animated: true)
    }
    
  
    @IBAction func signOutAction(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
        private func toggleColetion(cell: UITableViewCell, isCompleted: Bool) {
        cell.accessoryType = isCompleted ? .checkmark : .none
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let currentNote = notes[indexPath.row]
        cell.textLabel?.text = currentNote.title
        toggleColetion(cell: cell, isCompleted: currentNote.completed)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let note = notes[indexPath.row]
        let isComplete = !note.completed
        
        note.ref.updateChildValues(["completed" : isComplete])
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let note = notes[indexPath.row]
        note.ref.removeValue()
    }
    
}
