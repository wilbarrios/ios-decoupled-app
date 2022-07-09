import Foundation

public protocol HTTPClient {
  typealias ResponseResult = Result<Data, Error>
  func get(_ url: URL, responseHandler: @escaping (ResponseResult) -> Void)
}
