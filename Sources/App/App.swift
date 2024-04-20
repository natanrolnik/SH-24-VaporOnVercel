import Vercel
import VercelVapor
import MarkCodable

@main
struct App: VaporHandler {
    static func configure(app: Vapor.Application) async throws {
        app.get { _ in
            "Hello, SwiftHeroes 2024!"
        }

        app.get("agenda") { _ -> String in
            try await fetch("https://swiftheroes.com/swiftheroes-2024/schedule/v/final/widgets/schedule.json")
                .decode(Agenda.self, decoder: Agenda.decoder)
                .toTable()
        }
    }
}

extension Agenda {
    func toTable() throws -> String {
        let entries = talks
            .compactMap { talk in
                talk.toTableEntry(speakersMap)
            }
        return try MarkEncoder().encode(entries)
    }
}
