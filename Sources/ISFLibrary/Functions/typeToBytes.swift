/*
    typeToBytes.swift

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

/// Convert a type to  byte array.
///
/// - Parameters:
///   - value: The value to convert.
///
/// - Returns: the result as a byte array.
public func typeToBytes<T>(_ value: T) -> [Byte] {
    var mutableValue = value
    let typeSize = MemoryLayout<T>.size

    return withUnsafePointer(to: &mutableValue) {                                 // -> get pointer to value of T
        $0.withMemoryRebound(to: Byte.self, capacity: typeSize) {                 // -> rebind memory to the target type, which is a byte array
            Array(UnsafeBufferPointer(start: $0, count: typeSize))                // -> create array with a buffer pointer initialized with the source pointer
        }                                                                         // -> return the resulted array
    }
}
