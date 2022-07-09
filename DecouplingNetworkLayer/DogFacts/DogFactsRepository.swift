protocol DogFactsRepository {
  typealias DogFactResult = Result<DogFactData, DogFactError>
  func getRandomFact(handler: (DogFactResult) -> Void)
}
