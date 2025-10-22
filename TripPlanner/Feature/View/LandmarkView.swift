import FoundationModels
import SwiftUI
import os.log

let logger = Logger()

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

struct DetailView: View {

    @State private var requestedItinerary: Bool = false
    @State private var planner: ItineraryPlannerService?
    
    let landmark: Landmark
    
    var body: some View {
        VStack {
            Text(landmark.shortDescription)
                .font(.subheadline)
            
            Button(action: {
                Task {
                    try await requestItinerary()
                }
            }, label: {
                Label("Generate Itinerary", systemImage: "sparkles")
                    .fontWeight(.bold)
                    .padding()
            })
            
            if let itinerary = planner?.itinerary {
                ItineraryView(itinerary: itinerary)
            }
        }
        .padding()
        .navigationTitle(landmark.name)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            planner = ItineraryPlannerService(landmark: landmark)
            planner?.prewarm()
        }
    }
    
    func requestItinerary() async throws {
        logger.debug("Requisição de itinerário")
        requestedItinerary = true
        do {
            try await planner?.suggestItinerary(dayCount: 3)
            logger.debug("requisição finalizada")
        } catch {
            planner?.error = error
        }
    }
}

struct ItineraryView: View {
    
    var itinerary: Itinerary.PartiallyGenerated
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading) {
                if let title = itinerary.title {
                    Text(title)
                        .contentTransition(.opacity)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                
                if let description = itinerary.description {
                    Text(description)
                        .contentTransition(.opacity)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            if let rationale = itinerary.rationale {
                HStack(alignment: .top) {
                    Image(systemName: "sparkles")
                    Text(rationale)
                        .contentTransition(.opacity)
                }
            }
            
//            if let days = itinerary.days {
//                ForEach(days) { plan in
//                    DayView(
//                        landmark: landmark,
//                        plan: plan
//                    )
//                    .transition(.blurReplace)
//                }
//            }
        }
        .animation(.easeOut, value: itinerary)
    }
}
