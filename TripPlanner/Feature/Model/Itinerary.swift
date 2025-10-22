import Foundation
import FoundationModels

@Generable
struct Itinerary: Equatable {
    @Guide(description: "An exciting name for the trip.")
    let title: String
    
    @Guide(description: "The name of the place the itinerary is about.")
    let destinationName: String
    
    @Guide(description: "A longer description of the itinerary.")
    let description: String
    
    @Guide(description: "An explanation of how the itinerary meets the user's special requests.")
    let rationale: String
    
    @Guide(description: "A list of day-by-day plans.")
    @Guide(.count(3))
    let days: [DayPlan]
}

@Generable
struct DayPlan: Equatable {
    @Guide(description: "A unique and exciting title for this day plan.")
    let title: String
    
    @Guide(description: "A short, catchy subtitle summarizing the day's theme.")
    let subtitle: String
    
    @Guide(description: "The primary city or area for this day's plan (e.g., 'Kyoto', 'Shibuya').")
    let destination: String

    @Guide(.count(3))
    let activities: [Activity]
}

@Generable
struct Activity: Equatable {
    let type: Kind
    
    @Guide(description: "A catchy title for the activity.")
    let title: String
    
    @Guide(description: "A detailed description of the activity, including practical information like opening hours, location, or why it's interesting for the family.")
    let description: String
}

@Generable
enum Kind {
    case sightseeing
    case foodAndDining
    case shopping
    case hotelAndLodging
}
