//
//  NotesViewModel.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 22/11/2023.
//

import Foundation
import Firebase

// MARK: - Protocol
protocol NotesViewModelDelegate: AnyObject {
    func notesDidUpdate()
}

// MARK: - Class
class NotesViewModel {
    // MARK: - Properties
    var user: User
    var notes = [Note]()
    var ref: DatabaseReference
    weak var delegate: NotesViewModelDelegate?

    // MARK: - Initialization
    init(user: User) {
        self.user = user
        ref = Database.database().reference(withPath: "users").child(user.uid).child("notes")
        observeNotes()
    }

    // MARK: - Data Observation
    private func observeNotes() {
        ref.observe(.value) { [weak self] snapshot in
            var newNotes = [Note]()
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot, let note = Note(snapshot: snapshot) {
                    newNotes.append(note)
                }
            }
            self?.notes = newNotes
            self?.delegate?.notesDidUpdate()
        }
    }

    // MARK: - Adding a New Note
    func addNewNote(title: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let note = Note(title: title, userId: uid)
        let noteRef = ref.childByAutoId()
        noteRef.setValue(note.convertToDictionary())
    }

    // MARK: - Toggling Note Completion
    func toggleNoteCompletion(at indexPath: IndexPath) {
        let note = notes[indexPath.row]
        let isComplete = !note.completed
        note.ref.updateChildValues(["completed": isComplete])
    }

    // MARK: - Deleting a Note
    func deleteNote(at indexPath: IndexPath) {
        let note = notes[indexPath.row]
        note.ref.removeValue()
    }
}
