import SwiftUI

enum Theme {
    static let background = Color(red: 0.141, green: 0.102, blue: 0.071)
    static let accent = Color(red: 0.690, green: 0.537, blue: 0.329)
    static let accent2 = Color(red: 0.431, green: 0.545, blue: 0.239)
    static let cardBackground = Color(.secondarySystemGroupedBackground)

    static let titleFont = Font.system(.title2, design: .rounded).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)
}
