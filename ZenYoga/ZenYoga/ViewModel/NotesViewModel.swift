//
//  NotesViewModel.swift
//  ZenYoga
//
//  Created by Roman Litvinovich on 22/11/2023.
//

import Foundation
import Firebase
import FirebaseDatabaseInternal

// MARK: - Protocol
protocol NotesViewModelDelegate: AnyObject {
    func notesDidUpdate() // Протокол, который определяет метод, вызываемый при обновлении заметок
}

class NotesViewModel {
    
    // MARK: - Properties
    var user: User                               // Пользователь, для которого предназначены заметки
    var notes = [Note]()                         // Массив для хранения заметок
    var ref: DatabaseReference                   // Ссылка на базу данных Firebase
    weak var delegate: NotesViewModelDelegate?   // Делегат, для обновленых заметок
    
    // MARK: - Initialization
    init(user: User) {   // Инициализация модели с пользователем
        self.user = user
        ref = Database.database().reference(withPath: "users").child(user.uid).child("notes") // Получение ссылки на заметки пользователя в базе данных
        observeNotes()
    }
    
    // MARK: - Data Observation
    // Функция для отслеживания  заметок в базе данных
    private func observeNotes() {
        ref.observe(.value) { [weak self] snapshot in
            var newNotes = [Note]() // Создание нового массива для хранения заметок
            for child in snapshot.children { // Перебор всех дочерних элементов в снимке
                if let snapshot = child as? DataSnapshot, let note = Note(snapshot: snapshot) { // Если дочерний элемент является снимком данных и может быть преобразован в заметку
                    newNotes.append(note) // Добавление заметки в массив
                }
            }
            self?.notes = newNotes // Обновление массива заметок
            self?.delegate?.notesDidUpdate() // Уведомление делегата об обновлении заметок
        }
    }
    
    // MARK: - Adding a New Note
    func addNewNote(title: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return } // Получение идентификатора текущего пользователя
        let note = Note(title: title, userId: uid)                   // Создание новой заметки с заголовком и идентификатором пользователя
        let noteRef = ref.childByAutoId()                            // Создание нового дочернего элемента с уникальным идентификатором
        noteRef.setValue(note.convertToDictionary())
    }
    
    
    // MARK: - Deleting a Note
    func deleteNote(at indexPath: IndexPath) {
        let note = notes[indexPath.row] // Получение заметки по индексу
        note.ref.removeValue()          // Удаление заметки из базы данных
    }
}
