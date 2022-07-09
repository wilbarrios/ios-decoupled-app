extension DogFactsAPI {
  static var dev: Self {
    DogFactsAPI(
      environment: DogFactsEnvironment()
    )
  }
}
