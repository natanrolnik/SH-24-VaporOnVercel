import Foundation

struct Agenda: Codable {
    let talks: [Talk]
    let speakers: [Speaker]

    let speakersMap: [String: Speaker]

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.talks = try container.decode([Talk].self, forKey: .talks)
        self.speakers = try container.decode([Speaker].self, forKey: .speakers)

        speakersMap = speakers.reduce(into: [:]) { partialResult, speaker in
            partialResult[speaker.code] = speaker
        }
    }
}

extension Agenda {
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
}

struct Talk: Codable {
    let title: String?
    let room: Int
    let start: Date
    let speakers: [String]

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = (try? container.decode(String.self, forKey: .title)) ?? nil
        self.room = try container.decode(Int.self, forKey: .room)
        self.start = try container.decode(Date.self, forKey: .start)

        self.speakers = try container.decodeIfPresent([String].self, forKey: .speakers) ?? []
    }
}

struct Speaker: Codable {
    let code: String
    let name: String
}
