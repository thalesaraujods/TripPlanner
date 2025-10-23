import SwiftUI

struct DetailView: View {

    @State private var requestedItinerary: Bool = false
    @StateObject private var planner: ItineraryPlannerService
    
    let landmark: Landmark
    
    init(landmark: Landmark) {
        self.landmark = landmark
        self._planner = .init(wrappedValue: ItineraryPlannerService(landmark: landmark))
        self.planner.prewarm()
    }
    
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
            
            if let itinerary = planner.itinerary {
                ItineraryView(itinerary: itinerary)
            }
        }
        .padding()
        .navigationTitle(landmark.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func requestItinerary() async throws {
        logger.debug("-------Requisição de AI iniciada-------")
        requestedItinerary = true
        do {
            try await planner.suggestItinerary(dayCount: 3)
            logger.debug("Requisição de AI finalizada-------")
            logger.debug("\(planner.itinerary?.title as NSObject?)")
            logger.debug("\(planner.itinerary?.description as NSObject?)")
            logger.debug("\(planner.itinerary?.destinationName as NSObject?)")
        } catch {
            planner.error = error
        }
    }
}

//MARK: LOGGER
import os.log
private let logger = Logger(for: DetailView.self)
