import Foundation

protocol HTTPClient {
  typealias ResponseResult = Result<Data, Error>
  func get(_ url: URL?, responseHandler: (ResponseResult) -> Void)
}
