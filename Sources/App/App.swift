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
            throw Abort(.notImplemented, reason: "Live coding!")
        }
    }
}

extension Agenda {
    func toTable() throws -> String {
        throw Abort(.notImplemented, reason: "Live coding!")
    }
}
