import Glibc

public struct StdoutOutputStream: TextOutputStream {
    public mutating func write(_ string: String) {
        let ascii = string.unicodeScalars.lazy.map {
            ($0 == "\n") ? "\n" : $0.escaped(asASCII: true)
        }

        fputs(ascii.joined(separator: ""), stdout)
    }
}

public var outputStream = StdoutOutputStream()
