import Foundation

public let TAB: Character = "\t"
public let CR: Character = "\r\n"
public let addOp : [Character] = ["+", "-"]
public let mulOp : [Character] = ["*", "/"]
public let whiteChars: [Character] = [" ", TAB]

public struct Buffer {
  var idx: Int
  public var cur: Character?
  let input: String
  
  public init(idx: Int, cur: Character?, input: String) {
    self.idx = idx
    self.cur = cur
    self.input = input
  }
}

public extension Buffer {
  init() {
    idx = 0
    input = readLine()!
  }
  
  public mutating func getChar() {
    let i = input.index(input.startIndex, offsetBy: idx)
    
    if i == input.endIndex {
      cur = nil
    } else {
      cur = input[i]
      idx += 1
    }
  }
}

public extension Buffer {
  mutating func match(_ c: Character) {
    if cur == c {
      getChar()
    } else {
      expected("\(c)")
    }
  }
  
  mutating func getName() -> Character {
    if !isAlpha(cur) {
      expected("Name")
    }
    let lower = String(cur!).lowercased().first!
    getChar()
    return lower
  }

  mutating func getNum() -> Int {
    var value = 0
    
    if !isDigit(cur) {
      expected("Integer")
    }
    
    while isDigit(cur) {
      value = (10 * value) + Int(String(cur!))!
      getChar()
    }
    
    return value
  }
}

public func error(msg: String) {
  print("Error: \(msg).")
}

public func abort(msg: String) {
  error(msg: msg)
  exit(EXIT_FAILURE)
}

public func expected(_ s: String) {
  abort(msg: "\(s) expected")
}

public func emit(msg: String) {
  print("\(TAB) \(msg)", separator: "", terminator: "")
}

public func emitLine(msg: String) {
  print("\(TAB) \(msg)")
}

public func isAlpha(_ c: Character?) -> Bool {
  if let c = c, "a"..."z" ~= c || "A"..."Z" ~= c {
    return true
  } else {
    return false
  }
}

public func isDigit(_ c: Character?) -> Bool {
  if let c = c, "0"..."9" ~= c {
    return true
  } else {
    return false
  }
}

public func isAlphaNum(_ c: Character?) -> Bool {
  return isAlpha(c) || isDigit(c)
}

