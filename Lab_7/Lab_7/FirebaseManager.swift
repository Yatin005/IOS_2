//
//  FirebaseManager.swift
//  Lab_7
//
//  Created by yatin PArulkaron on 2025-08-01.
//
// FirebaseManager.swift
import Foundation
import FirebaseDatabase

class FirebaseManager {
    private let databaseRef = Database.database().reference()

    func saveJournalEntry(text: String, latitude: Double, longitude: Double) {
        let entry = [
            "text": text,
            "latitude": latitude,
            "longitude": longitude,
            "timestamp": [".sv": "timestamp"]
        ] as [String : Any]

        databaseRef.child("journal-entries").childByAutoId().setValue(entry) { error, _ in
            if let error = error {
                print("Data could not be saved: \(error.localizedDescription)")
            } else {
                print("Data saved successfully!")
            }
        }
    }
}
