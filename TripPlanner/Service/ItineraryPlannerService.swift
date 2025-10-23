import FoundationModels
import Observation
import SwiftUI
internal import Combine

final class ItineraryPlannerService: ObservableObject {
    @Published private(set) var itinerary: Itinerary.PartiallyGenerated?
    private var session: LanguageModelSession
    
    var error: Error?
    let landmark: Landmark
    
    init(landmark: Landmark) {
        self.landmark = landmark
        itineraryPlannerLogger.info("The landmark is... \(landmark.name)")
        
        self.session = LanguageModelSession(
            instructions: Instructions {
                "Your job is to create an itinerary for the user."
                
                "Each day needs an activity, hotel and restaurant."

                """
                Here is a description of \(landmark.name) for your reference \
                when considering what activities to generate:
                """
                landmark.description
            }
        )
    }
    
    func suggestItinerary(dayCount: Int) async throws{
        let stream = session.streamResponse(
            generating: Itinerary.self,
            includeSchemaInPrompt: true,
            options: GenerationOptions(sampling: .greedy)
        ) {
            "Generate a \(dayCount)-day itinerary to \(landmark.name)."
            
            "Give it a fun title and description."
            
            "Here is an example, but don't copy it:"
            Itinerary.exampleTripToJapan
        }
        
        for try await partialResponse in stream {
            itinerary = partialResponse.content
        }
    }
    
    func prewarm() {
        session.prewarm()
    }
}

// MARK: - Logger
import os.log
private let itineraryPlannerLogger = Logger(category: "ItineraryPlannerService")
