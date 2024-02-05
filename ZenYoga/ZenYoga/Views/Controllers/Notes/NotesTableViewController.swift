//
//  NotesTableViewController.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 22/11/2023.
//

import UIKit
import Firebase
import FirebaseAuth

class NotesTableViewController: UITableViewController, NotesViewModelDelegate {
    
    // MARK: - Properties
    private var viewModel: NotesViewModel!

    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentUser = Auth.auth().currentUser else { return } // Получение текущего пользователя
        let user = User(user: currentUser)
        viewModel = NotesViewModel(user: user)
        viewModel.delegate = self
    }

    // MARK: - Actions
    @IBAction func addNewNoteAction(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title:"", message: "Add new note", preferredStyle: .alert)
        alertController.addTextField()
        let save = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let self = self,
                  let textField = alertController.textFields?.first,
                  let text = textField.text else { return }
            self.viewModel.addNewNote(title: text)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancel)
        alertController.addAction(save)
        present(alertController, animated: true)
    }

    // MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath)
        let currentNote = viewModel.notes[indexPath.row]
        cell.textLabel?.text = currentNote.title
        toggleCompletion(cell, isCompleted: currentNote.completed)
        return cell
    }

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            let note = self.viewModel.notes[indexPath.row]
            let alertController = UIAlertController(title: "Edit Note", message: "", preferredStyle: .alert)
            alertController.addTextField { textField in
                textField.text = note.title
            }
            let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
                if let newText = alertController.textFields?.first?.text {
                    note.ref.updateChildValues(["title": newText])
                }
            }
            alertController.addAction(saveAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true)
            completionHandler(true)
        }
        editAction.backgroundColor = .blue
        let configuration = UISwipeActionsConfiguration(actions: [editAction])
        return configuration
    }

    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        viewModel.deleteNote(at: indexPath)
    }

    private func toggleCompletion(_ cell: UITableViewCell, isCompleted: Bool) {
        cell.accessoryType = isCompleted ? .checkmark : .none
    }
    
    // MARK: NotesViewModelDelegate
    func notesDidUpdate() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
