struct DogFactData {
  let factMessage: String
}

extension DogFactData {
  static var empty: DogFactData { DogFactData(factMessage: "") }
}
