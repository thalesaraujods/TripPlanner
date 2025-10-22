import FoundationModels
import SwiftUI

struct LandmarkView: View {
    
    var data: ModelData = ModelData.shared
    
    var body: some View {
        NavigationStack {
            List(data.landmarks) { landmark in
                NavigationLink(destination: DetailView(landmark: landmark)) {
                    Text(landmark.name)
                }
            }
            .navigationTitle("Cidades")
        }
    }
}

//MARK: LOGGER
import os.log
private let logger = Logger(for: LandmarkView.self)


