//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Paul Houghton on 06/10/2020.
//

import SwiftUI

class User: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case name
    }
    
    @Published var name = "Paul Hudson"
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    @ObservedObject var order = Order()
    
    
//    @State private var results = [Result]()
    
//    @State var username = ""
//    @State var email = ""
//
//    var disableForm: Bool {
//        username.count < 5 || email.count < 5
//    }
    
    var body: some View {

        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.theOrder.type) {
// Fix for foreach error if it shows...
//                        ForEach(0..<Order.types.count, id: \.self) {
                        ForEach(0..<TheOrder.types.count) {
                            Text(TheOrder.types[$0])
                        }
                    }
                    
                    Stepper(value: $order.theOrder.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.theOrder.quantity)")
                    }
                }
                    
                Section {
                    Toggle(isOn: $order.theOrder.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if order.theOrder.specialRequestEnabled {
                        Toggle(isOn: $order.theOrder.extraFrosting ) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $order.theOrder.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(order: order)) {
                        Text("Delivery Details")
                    }
                }
            
            }
            .navigationBarTitle("Cupcake Corner")
        }
        
        
//        List(results, id:\.trackId) { item in
//            VStack(alignment: .leading) {
//                Text(item.trackName)
//                    .font(.headline)
//
//                Text(item.collectionName)
//            }
//        }
//        .onAppear(perform: loadData)
    
//    func loadData() {
//        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
//            print("Invalid URL")
//            return
//        }
//
//        let request = URLRequest(url: url)
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data {
//                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
//                    DispatchQueue.main.async {
//                        self.results = decodedResponse.results
//                    }
//
//                    return
//                }
//            }
//            print("Fetch failed: \(error?.localizedDescription ?? "Unknown Error")")
//
//        }.resume()
    
//        Form {
//            Section {
//                TextField("Username", text: $username)
//                TextField("Email", text: $email)
//            }
//
//            Section {
//                Button("Create account") {
//                    print("Creating account...")
//                }
//            }
//            .disabled(disableForm)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
