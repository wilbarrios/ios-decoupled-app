protocol DogFactsRepository {
  typealias DogFactResult = Result<DogFactData, DogFactError>
  func getRandomFact(handler: @escaping (DogFactResult) -> Void)
}
