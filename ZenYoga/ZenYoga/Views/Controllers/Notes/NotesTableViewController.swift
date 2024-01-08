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
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont(name: "ChalkboardSE-Regular", size: 23)!,
             NSAttributedString.Key.foregroundColor: UIColor.black]
        guard let currentUser = Auth.auth().currentUser else { return }
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
