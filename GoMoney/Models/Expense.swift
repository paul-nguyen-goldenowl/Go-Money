import RealmSwift
import UIKit

class Expense: Object, Codable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var type: String
    @Persisted var tag: String
    @Persisted var amount: Double
    @Persisted var note: String
    @Persisted var occuredOn: Date
    @Persisted var createdAt: Date?
    @Persisted var updatedAt: Date?

    convenience init(type: ExpenseType = .expense, tag: TransactionTag = .food, amount: Double, note: String = "", occuredOn: Date, createdAt: Date? = Date(), updatedAt: Date? = nil) {
        self.init()
        self.type = type.rawValue
        self.tag = tag.getName()
        self.amount = amount
        self.note = note
        self.occuredOn = occuredOn
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    enum CodingKeys: String, CodingKey {
        case _id
        case type
        case tag
        case amount
        case note
        case occuredOn
        case createdAt
        case updatedAt
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_id, forKey: ._id)
        try container.encode(type, forKey: .type)
        try container.encode(tag, forKey: .tag)
        try container.encode(amount, forKey: .amount)
        try container.encode(note, forKey: .note)
        try container.encode(occuredOn, forKey: .occuredOn)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
    }
}

enum ExpenseType: String {
    case income, expense
}

enum ExpenseSort: String {
    case createdAt
    case updatedAt
    case occuredOn
}

enum ExpenseFilter {
    case all
    case week
    case month
    case year

    static let allFilters: [ExpenseFilter] = [.week, .month, .year, .all]

    func getName() -> String {
        switch self {
        case .all:
            return "All"
        case .week:
            return "This Week"
        case .month:
            return "This Month"
        case .year:
            return "This Year"
        }
    }
}

struct TagAmount {
    let tag: String
    var totalAmount: Double
}

struct DateAmount {
    let date: Date
    var totalAmount: Double
}
