import Foundation
enum DogFactError: Error {
  case notParsable(Data)
  case fetchError(Error)
}
