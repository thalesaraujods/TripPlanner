extension Itinerary {
    static let exampleTripToJapan = Itinerary(
        title: "Onsen Trip to Japan",
        destinationName: "Mt. Fuji",
        description: "Sushi, hot springs, and ryokan with a toddler!",
        rationale:
            """
            You are traveling with a child, so climbing Mt. Fuji is probably not an option, \
            but there is lots to do around Kawaguchiko Lake, including Fujikyu. \
            I recommend staying in a ryokan because you love hotsprings.
            """,
        days: [
            DayPlan(
                title: "Sushi and Shopping Near Kawaguchiko",
                subtitle: "Spend your final day enjoying sushi and souvenir shopping.",
                destination: "Kawaguchiko Lake",
                activities: [
                    Activity(
                        type: .foodAndDining,
                        title: "The Restaurant serving Sushi",
                        description: "Visit an authentic sushi restaurant for lunch."
                    ),
                    Activity(
                        type: .shopping,
                        title: "The Plaza",
                        description: "Enjoy souvenir shopping at various shops."
                    ),
                    Activity(
                        type: .sightseeing,
                        title: "The Beautiful Cherry Blossom Park",
                        description: "Admire the beautiful cherry blossom trees in the park."
                    ),
                    Activity(
                        type: .hotelAndLodging,
                        title: "The Hotel",
                        description:
                            "Spend one final evening in the hotspring before heading home."
                    )
                ]
            )
        ]
    )
}
