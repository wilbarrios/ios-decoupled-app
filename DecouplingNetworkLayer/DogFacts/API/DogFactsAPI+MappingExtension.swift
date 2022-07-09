import Foundation

extension DogFactsAPI {
  var factsURL: URL { getURL(path: "facts") }
}

// MARK: - Helpers
fileprivate extension DogFactsAPI {
  func getURL(path: String) -> URL {
    URL(string: "\(environment.baseURL)/\(path)")!
  }
}
