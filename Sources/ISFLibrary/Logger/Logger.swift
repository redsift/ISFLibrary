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

/// 'do' 'catch' wrapper too catch thrown errors, mainly used to catch in
/// unthrowable code such as 'defer' and async code.
public func wrapper<T>(do closure:   @escaping () throws -> T,
                       catch failed: @escaping (ErrorLoggerResult) -> Void = errorLogger,
                       file:         String = #file,
                       line:         Int = #line,
                       column:       Int = #column,
                       function:     String = #function,
                       capture:      @escaping () -> Array<Any> = { return [] }) -> T? {
    do {
        return try closure()
    } catch {
        failed(ErrorLoggerResult(error:    error,
                                 file:     file,
                                 line:     line,
                                 column:   column,
                                 function: function,
                                 objects:  capture()))

        return nil
    }
}

/// log a message at a given level by calling the 'logger' closure.
public func logger(level:     LoggerLevel,
                   _ message: String,
                   file:      String = #file,
                   line:      Int = #line,
                   column:    Int = #column,
                   function:  String = #function,
                   objects:   Array<Any> = []) {
    logger(LoggerResult(level:    level,
                        message:  message,
                        file:     file,
                        line:     line,
                        column:   column,
                        function: function,
                        objects:  objects))
}

/// log an error by calling the 'errorLogger' closure.
public func logger(error:    Error,
                   file:     String = #file,
                   line:     Int = #line,
                   column:   Int = #column,
                   function: String = #function,
                   objects:  Array<Any> = []) {
    errorLogger(ErrorLoggerResult(error:    error,
                                  file:     file,
                                  line:     line,
                                  column:   column,
                                  function: function,
                                  objects:  objects))
}

/// default closure to intercept thrown errors such as from the do catch wrapper,
/// can be overidden to plugin your own code to deal with errors by default chains
/// down to the 'logger' closure to deal with the logging of the error.
public var errorLogger: (ErrorLoggerResult) -> Void = { failure in
    print("errorLogger ~ \(failure.description)", to: &errorStream)

    logger(level:    .Error,
                     "\(failure.error)",
           file:     failure.file,
           line:     failure.line,
           column:   failure.column,
           function: failure.function,
           objects:  failure.objects)
}

/// default closure to log errors and and messages, can be overidden to plugin your
/// own code or favorite logging package.
public var logger: (LoggerResult) -> Void = { log in
    print("logger ~ \(log.description)", to: &outputStream)
}
