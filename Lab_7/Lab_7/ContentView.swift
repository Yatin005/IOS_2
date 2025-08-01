//
//  ContentView.swift
//  Lab_7
//
//  Created by Deep Kaleka on 2025-07-29.
//
// ContentView.swift
import SwiftUI
import MapKit
import CoreLocation

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var locationHelper = LocationHelper()
    @State private var journalText: String = ""
    private let firebaseManager = FirebaseManager()
    
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 43.64253, longitude: -79.38201),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    @State private var searchQuery: String = ""
    @State private var searchLocationPin: MKPointAnnotation?
    @State private var currentAddress: String = "No address found"

    var body: some View {
        VStack {
            Text("Location Journal")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            // Forward Geocoding (Search Bar)
            HStack {
                TextField("Search for a location...", text: $searchQuery)
                    .textFieldStyle(.roundedBorder)
                
                Button(action: performSearch) {
                    Image(systemName: "magnifyingglass")
                        .padding(5)
                }
            }
            .padding(.horizontal)
            
            Map(coordinateRegion: $mapRegion, showsUserLocation: true, annotationItems: [searchLocationPin].compactMap { $0 }) { pin in
                MapAnnotation(coordinate: pin.coordinate) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.blue)
                        .font(.title)
                }
            }
            .frame(height: 300)
            .cornerRadius(10)
            .padding()
            .onAppear {
                if let location = locationManager.lastKnownLocation {
                    mapRegion = MKCoordinateRegion(
                        center: location.coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                    )
                }
            }

            // Reverse Geocoding (Get Address Button)
            Button("Get Address") {
                performReverseGeocoding()
            }
            .buttonStyle(.bordered)
            .padding(.top, -10)
            
            Text(currentAddress)
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            TextEditor(text: $journalText)
                .frame(height: 150)
                .border(Color.gray)
                .padding()
            
            Button("Save Journal Entry") {
                let saveLat = mapRegion.center.latitude
                let saveLng = mapRegion.center.longitude
                
                guard !journalText.isEmpty else { return }

                firebaseManager.saveJournalEntry(
                    text: journalText,
                    latitude: saveLat,
                    longitude: saveLng
                )
                journalText = ""
            }
            .buttonStyle(.borderedProminent)
            .disabled(journalText.isEmpty)
            .padding()
        }
    }
    
    // Function for Forward Geocoding
    private func performSearch() {
        guard !searchQuery.isEmpty else { return }
        
        locationHelper.doForwardGeocoding(address: searchQuery) { (coordinates, error) in
            if let coordinates = coordinates {
                withAnimation {
                    mapRegion.center = coordinates.coordinate
                    mapRegion.span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                }
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinates.coordinate
                self.searchLocationPin = annotation
            } else {
                print("Could not find location for the search query.")
                self.searchLocationPin = nil
            }
        }
    }
    
    // Function for Reverse Geocoding
    private func performReverseGeocoding() {
        let centerLocation = CLLocation(latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
        locationHelper.doReverseGeocoding(location: centerLocation) { (address, error) in
            if let address = address {
                self.currentAddress = address
            } else {
                self.currentAddress = "Unable to find address."
            }
        }
    }
}
