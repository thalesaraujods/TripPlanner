import Foundation
import os.log

public extension Logger {
    init(category: String) {
        self.init(
            subsystem: Bundle.main.bundleIdentifier ?? Bundle.main.description,
            category: category)
    }
     
    init<T>(for type: T.Type) {
        self.init(category: String(describing: T.self))
    }
}
