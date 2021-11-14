import SwiftUI

struct ContentView: View {
    
    @State var keys: [Key] = []
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack {
                  Color.red
                    .edgesIgnoringSafeArea(.all)
                  
                    HStack(alignment: .lastTextBaseline, spacing: 100){
                        Text("Key").font(.title).foregroundColor(.blue)
                        Text("Select")
                        .font(.title)
                        .foregroundColor(.blue)
                        .padding()
                        .overlay(
                           RoundedRectangle(cornerRadius: 15)
                               .stroke(Color.blue, lineWidth: 3)
                        )
                    }
                    
                }
                .onAppear(perform: readFile)
                
                ForEach(keys) { key in
                    NavigationLink(destination: KeyView(key: key)) {
                        Text(key.keyName)
                               }.navigationBarTitle(Text("KeyView"))
                }
            }
        }
    }
    
    private func readFile(){
            let url = Bundle.main.url(forResource: "keys", withExtension: "json")!
            let data = try! Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try! decoder.decode(JSONData.self, from:data)
            self.keys = jsonData.keys
    }
    
}

struct JSONData : Decodable {
    let keys: [Key]
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
