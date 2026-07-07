import Foundation

struct SoilTest: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var date: Date = Date()
    var bed: String
    var ph: String
    var npk: String
}
