/*
    TimeInterval.swift

    Copyright (c) 2016, 2017 Stephen Whittle  All rights reserved.

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"),
    to deal in the Software without restriction, including without limitation
    the rights to use, copy, modify, merge, publish, distribute, sublicense,
    and/or sell copies of the Software, and to permit persons to whom
    the Software is furnished to do so, subject to the following conditions:
    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
    THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
    IN THE SOFTWARE.
*/

import Foundation

private let secondsPerMinute:      Double = 60
private let secondsPerHour:        Double = secondsPerMinute * 60
private let secondsPerDay:         Double = secondsPerHour * 24

private let decisecondsPerSecond:  Double = 10
private let centisecondsPerSecond: Double = 100
private let millisecondsPerSecond: Double = 1_000
private let microsecondsPerSecond: Double = 1_000_000

public extension TimeInterval {
    public init(days: Int) {
        self = Double(days) * secondsPerDay
    }
}

public extension TimeInterval {
    public init(hours: Int) {
        self = Double(hours) * secondsPerHour
    }
}

public extension TimeInterval {
    public init(minutes: Int) {
        self = Double(minutes) * secondsPerMinute
    }
}

public extension TimeInterval {
    public init(seconds: Int) {
        self = Double(seconds)
    }

    public init(seconds: TimeInterval) {
        self = seconds
    }

    public var wholeSeconds: Int {
        return Int(floor(self))
    }

    public var seconds: TimeInterval {
        return self
    }
}

public extension TimeInterval {
    public init(deciseconds: Int) {
        self = Double(deciseconds) / decisecondsPerSecond
    }

    public var deciseconds: Int {
        return Int(self * decisecondsPerSecond)
    }
}

public extension TimeInterval {
    public init(centiseconds: Int) {
        self = Double(centiseconds) / centisecondsPerSecond
    }

    public var centiseconds: Int {
        return Int(self * centisecondsPerSecond)
    }
}

public extension TimeInterval {
    public init(milliseconds: Int) {
        self = Double(milliseconds) / millisecondsPerSecond
    }

    public var milliseconds: Int {
        return Int(self * millisecondsPerSecond)
    }
}

public extension TimeInterval {
    public init(microseconds: CUnsignedInt) {
        self = Double(microseconds) / microsecondsPerSecond
    }

    public var microseconds: CUnsignedInt {
        return CUnsignedInt(self * microsecondsPerSecond)
    }
}
