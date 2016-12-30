/*
    TimeInterval.swift

    Copyright (c) 2016 Stephen Whittle  All rights reserved.

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

public let secondsPerMinute:      TimeInterval = 60
public let secondsPerHour:        TimeInterval = secondsPerMinute * 60
public let secondsPerDay:         TimeInterval = secondsPerHour * 24
public let millisecondsPerSecond: TimeInterval = 1000
public let microsecondsPerSecond: TimeInterval = millisecondsPerSecond * 1000

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

    @available(*, renamed: "seconds")
    public var asSeconds: Int {
        return Int(floor(self))
    }

    public var seconds: Int {
        return Int(floor(self))
    }
}

public extension TimeInterval {
    public init(milliseconds: Int) {
        self = Double(milliseconds) / millisecondsPerSecond
    }

    @available(*, renamed: "milliseconds")
    public var asMilliseconds: Int {
        return Int(self * millisecondsPerSecond)
    }

    public var milliseconds: Int {
        return Int(self * millisecondsPerSecond)
    }
}

public extension TimeInterval {
    public init(microseconds: CUnsignedInt) {
        self = Double(microseconds) / microsecondsPerSecond
    }

    @available(*, renamed: "microseconds")
    public var asMicroseconds: CUnsignedInt {
        return CUnsignedInt(self * microsecondsPerSecond)
    }

    public var microseconds: CUnsignedInt {
        return CUnsignedInt(self * microsecondsPerSecond)
    }
}
