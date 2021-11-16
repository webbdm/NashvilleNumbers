import SwiftUI

struct ContentView: View {
    
    @State var keys: [Key] = []
    
    private func getScale(proxy: GeometryProxy) -> CGFloat {
        var scale: CGFloat = 1
        
        let x = proxy.frame(in: .global).minX
        let diff = abs(x)
        if 125...225 ~= diff {
            scale = 1 + (225 - diff) / 500
        }
        
        return scale
    }
    
    var body: some View {
        NavigationView{
            VStack{
              ZStack {
               Color.red.edgesIgnoringSafeArea(.all)

                    
                VStack{
                        HStack(alignment: .lastTextBaseline, spacing: 175){
                            Text("Key").font(.largeTitle).foregroundColor(.blue)
                            Text("Select")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                            .padding()
                            .overlay(
                               RoundedRectangle(cornerRadius: 15)
                                   .stroke(Color.blue, lineWidth: 3)
                            )
                }
                //Spacer()
                ScrollView(.horizontal){
                   HStack(spacing: 50){
                       ForEach(keys) { key in
                           GeometryReader { proxy in
                              NavigationLink(destination: KeyView(key: key)) {
                               Text(key.keyName)
                               .foregroundColor(.black)
                               .font(.largeTitle)
                               .frame(width:150)
                               .cornerRadius(5)
                               .shadow(radius: 5)
                            }

                           }
                           .background(Color.blue)
                           .frame(width:155,height: 300)
                               
                       }
                   }.padding(25)
               }
               Spacer()
            }.onAppear(perform: readFile)
                    
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
        ContentView(keys:
            [Key(id: 1, keyName: "C", notes: [
            Note(id:1,number:1,noteName: "C"),
            Note(id:1,number:1,noteName: "Dm"),
            Note(id:1,number:1,noteName: "Em"),
            Note(id:1,number:1,noteName: "F"),
            Note(id:1,number:1,noteName: "G"),
            Note(id:1,number:1,noteName: "Am"),
            Note(id:1,number:1,noteName: "B")
        ])]
        )
    }
}
