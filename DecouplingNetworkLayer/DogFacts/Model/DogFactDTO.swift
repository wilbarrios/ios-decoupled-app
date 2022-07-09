/**
 JSON Response:
 ```
 {
     "facts": [
         "Puppies then take a year or more to gain the other half of their body weight."
     ],
     "success": true
 }
 ```
 */
internal struct DogFactDTO: Decodable {
  let facts: [String]?
  let success: Bool?
}
