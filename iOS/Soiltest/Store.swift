import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    static let freeLimit = 8

    @Published var items: [SoilTest] = []
    @Published var isPro: Bool = false

    private let fileURL: URL

    init() {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        fileURL = dir.appendingPathComponent("soiltest_items.json")
        load()
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: SoilTest) {
        items.insert(item, at: 0)
        save()
    }

    func update(_ item: SoilTest) {
        if let idx = items.firstIndex(where: { $0.id == item.id }) {
            items[idx] = item
            save()
        }
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: SoilTest) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([SoilTest].self, from: data) else {
            items = Store.seedData()
            save()
            return
        }
        items = decoded
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    static func seedData() -> [SoilTest] {
        [
        SoilTest(date: Date().addingTimeInterval(-86400), bed: "Raised Bed 1", ph: "6.5", npk: "10-10-10"),
        SoilTest(date: Date().addingTimeInterval(-172800), bed: "South Border", ph: "7.1", npk: "5-10-5"),
        SoilTest(date: Date().addingTimeInterval(-259200), bed: "Herb Spiral", ph: "6.8", npk: "balanced")
        ]
    }
}
