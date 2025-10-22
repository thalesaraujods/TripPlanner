import Foundation
import SwiftUI

@Observable
class ModelData {
    @MainActor
    static let shared = ModelData()
    
    nonisolated let landmarks: [Landmark] = parseLandmarks(fileName: "landmarkData.json")
    nonisolated var landmarkNames: [String] { landmarks.map(\.name)}
    var landmarksByID: [Int: Landmark] = [:]
    
    private init() {
        loadLandmarks()
    }
    
    func loadLandmarks() {
        for landmark in landmarks {
            landmarksByID[landmark.id] = landmark
        }
    }
    
    static func parseLandmarks(fileName: String) -> [Landmark] {
        guard let file = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            fatalError("Couldn't find \(fileName) in main bundle.")
        }

        do {
            let data: Data = try Data(contentsOf: file)
            let decoder = JSONDecoder()
            return try decoder.decode([Landmark].self, from: data)
        } catch {
            fatalError("Couldn't parse \(fileName):\n\(error)")
        }
    }
}
