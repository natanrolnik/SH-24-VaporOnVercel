import Foundation

struct TableEntry: Codable {
    let title: String
    let speakers: String
    let date: Date
    let formattedDate: String
    let room: Room

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(formattedDate, forKey: .formattedDate)
        try container.encode(title, forKey: .title)
        try container.encode(speakers, forKey: .speakers)
        try container.encode(room, forKey: .room)
    }
}

extension TableEntry: Comparable {
    static func < (lhs: TableEntry, rhs: TableEntry) -> Bool {
        lhs.date < rhs.date
    }
}

enum Room: String, Codable {
    case auditorium
    case sala

    init(from roomNumber: Int) {
        self = roomNumber == 6 ? .auditorium : .sala
    }
}

private let talksDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    formatter.timeZone = .init(identifier: "Europe/Rome")
    return formatter
}()

extension Talk {
    func toTableEntry(_ speakersMap: [String: Speaker]) -> TableEntry? {
        guard let title = title, !speakers.isEmpty else {
            return nil
        }

        return TableEntry(
            title: title,
            speakers: speakers.compactMap { speakersMap[$0]?.name }.joined(separator: ", "),
            date: start,
            formattedDate: talksDateFormatter.string(from: start),
            room: Room(from: room)
        )
    }
}
