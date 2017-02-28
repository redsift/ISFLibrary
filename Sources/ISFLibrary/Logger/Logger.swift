/*
    Logger.swift

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

public func doCatchWrapper<T>(file:     String = #file,
                              line:     Int = #line,
                              column:   Int = #column,
                              function: String = #function,
                              funcCall: @escaping () throws -> T,
                              failed:   @escaping (LoggerResults) -> Void = logger) -> T? {
    do {
        return try funcCall()
    } catch {
        failed(LoggerResults(error:    error,
                             file:     file,
                             line:     line,
                             column:   column,
                             function: function))

        return nil
    }
}

public func doCatchWrapper<T>(file:        String = #file,
                              line:        Int = #line,
                              column:      Int = #column,
                              function:    String = #function,
                              funcCall:    @escaping () throws -> T,
                              failed:      @escaping (LoggerResults) -> Void = logger,
                              objectsFunc: @escaping () -> [Any]) -> T? {
    do {
        return try funcCall()
    } catch {
        failed(LoggerResults(error:    error,
                             file:     file,
                             line:     line,
                             column:   column,
                             function: function,
                             objects:  objectsFunc()))

        return nil
    }
}

public var logger = { (failure: LoggerResults) -> Void in
    print("\(failure.description)", to: &errorStream)
}
