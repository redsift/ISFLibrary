import Glibc

public struct StderrOutputStream: TextOutputStream {
    public mutating func write(_ string: String) { fputs(string, stderr) }
}

public var errorStream = StderrOutputStream()
