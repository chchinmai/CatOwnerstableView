import Foundation

final class NetworkService {
    func getOwners(completionHandler: @escaping ([Owner]) -> Void) {
//        let url = URL(string: "https://agl-developer-test.azurewebsites.net/people.json")!
//        URLSession.shared.dataTask(with: url) { data, _, _ in
//            guard let data else { return }
//            guard let owners = try? JSONDecoder().decode([Owner].self, from: data) else { return }
//            print("data here \(owners)")
//            completionHandler(owners)
//        }.resume()
        let url = "https://agl-developer-test.azurewebsites.net/people.json"
          URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in

              if let d = data {
                  if let value = String(data: d, encoding: String.Encoding.ascii) {

                      if let jsonData = value.data(using: String.Encoding.utf8) {
                          do {
                              let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
                              print("json here \(json)")
                              do {
                                let result = try JSONDecoder().decode([Owner].self, from: jsonData)
                                  print("result \(result)")
                                  completionHandler(result)
                              }
                              catch let DecodingError.dataCorrupted(context) {
                                  print(context)
                              } catch let DecodingError.keyNotFound(key, context) {
                                  print("Key '\(key)' not found:", context.debugDescription)
                                  print("codingPath:", context.codingPath)
                              } catch let DecodingError.valueNotFound(value, context) {
                                  print("Value '\(value)' not found:", context.debugDescription)
                                  print("codingPath:", context.codingPath)
                              } catch let DecodingError.typeMismatch(type, context)  {
                                  print("Type '\(type)' mismatch:", context.debugDescription)
                                  print("codingPath:", context.codingPath)
                              } catch {
                                  print("error: ", error)
                              }

                          } catch {
                              NSLog("ERROR \(error.localizedDescription)")
                          }
                      }
                  }

              }
              }.resume()
    }
 
}

