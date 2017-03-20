/*
    String.swift

    Copyright (c) 2017 Stephen Whittle  All rights reserved.

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

public extension String {
    private struct NumericRegex {
        static let integer               = "^[-+]?[0-9]+$"
        static let positiveInteger       = "^[+]?[0-9]+$"
        static let negativeInteger       = "^[-][0-9]+$"
        static let decimal               = "^[-+]?([0-9]+|\\.[0-9]+|[0-9]+\\.[0-9]+)$"
        static let positiveDecimal       = "^[+]?([0-9]+|\\.[0-9]+|[0-9]+\\.[0-9]+)$"
        static let negativeDecimal       = "^[-]([0-9]+|\\.[0-9]+|[0-9]+\\.[0-9]+)$"
        static let floatingPoint         = "^(?:[-+]?(?:[0-9]+))?(?:\\.[0-9]*)?(?:[eE][\\+\\-]?(?:[0-9]+))?$"
        static let positiveFloatingPoint = "^(?:[+]?(?:[0-9]+))?(?:\\.[0-9]*)?(?:[eE][\\+\\-]?(?:[0-9]+))?$"
        static let negativeFloatingPoint = "^(?:[-](?:[0-9]+))?(?:\\.[0-9]*)?(?:[eE][\\+\\-]?(?:[0-9]+))?$"
    }

    public var isInteger: Bool {
        return (self =~ NumericRegex.integer)
    }

    public var isPositiveInteger: Bool {
        return (self =~ NumericRegex.positiveInteger)
    }

    public var isNegativeInteger: Bool {
        return (self =~ NumericRegex.negativeInteger)
    }

    public var isDecimal: Bool {
        return (self =~ NumericRegex.decimal)
    }

    public var isPositiveDecimal: Bool {
        return (self =~ NumericRegex.positiveDecimal)
    }

    public var isNegativeDecimal: Bool {
        return (self =~ NumericRegex.negativeDecimal)
    }

    public var isFloatingPoint: Bool {
        return (self != "." && self =~ NumericRegex.floatingPoint)
    }

    public var isPositiveFloatingPoint: Bool {
        return (self != "." && self =~ NumericRegex.positiveFloatingPoint)
    }

    public var isNegativeFloatingPoint: Bool {
        return (self != "." && self =~ NumericRegex.negativeFloatingPoint)
    }
}
