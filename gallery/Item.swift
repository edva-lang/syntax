import Foundation

public struct FileItem: Identifiable, Hashable, Sendable {
    public let id: UUID
    public let filename: String
    public let byteSize: Int64
    public let isDirectory: Bool

    public init(id: UUID = UUID(), filename: String, byteSize: Int64, isDirectory: Bool = false) {
        self.id = id
        self.filename = filename
        self.byteSize = byteSize
        self.isDirectory = isDirectory
    }

    public var formattedSize: String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useAll]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: byteSize)
    }
}

actor FileStore {
    private var items: [UUID: FileItem] = [:]

    func insert(_ item: FileItem) {
        items[item.id] = item
    }

    func count() -> Int {
        return items.count
    }
}
