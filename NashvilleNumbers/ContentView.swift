import SwiftUI

struct ContentView: View {
    
    @State var keys: [Key] = []
    @State var songs: [Song] = []

    
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
                Color("redbg").edgesIgnoringSafeArea(.all)

                    
                VStack{
                        HStack(alignment: .lastTextBaseline, spacing: 175){
                            Text("Key").font(.largeTitle).foregroundColor(Color("panel"))
                            Text("Select")
                            .font(.largeTitle)
                            .foregroundColor(Color("panel"))
                            .padding()
                            .overlay(
                               RoundedRectangle(cornerRadius: 15)
                                   .stroke(Color("panel"), lineWidth: 3)
                            )
                }

                ScrollView(.horizontal){
                   HStack(spacing: 50){
                       ForEach(keys) { key in
                           GeometryReader { proxy in
                              NavigationLink(destination: KeyView(key: key)) {
                               Text(key.keyName)
                               .foregroundColor(.white)
                               .font(.largeTitle)
                               .frame(width:150)
                               .cornerRadius(5)
                               .shadow(radius: 5)
                            }

                           }
                           .background(Color("panel"))
                           .frame(width:155,height: 300)
                           .cornerRadius(20)
                               
                       }
                   }.padding(25)
               }
               Spacer()
                    
                VStack(){
                   Text("Songs")
                    .padding()
                    .font(.system(size:56.0))
                    .foregroundColor(Color("panel"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ForEach(songs) { song in
                        HStack(alignment: .firstTextBaseline, spacing: 175){
                            Text(song.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.white)
                            Text(song.key)
                                .foregroundColor(Color("panel"))
                        }.padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                    }
                    Spacer()
                    NavigationLink(destination: SongsView()) {
                       Text("View All Songs")
                       .padding()
                       .background(Color("panel"))
                       .cornerRadius(5)
                       .foregroundColor(Color(.white))
                        .font(.headline)
                       .frame(width:150)
                    }
                                   
            }
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
        
            let url2 = Bundle.main.url(forResource: "keys", withExtension: "json")!
            let data2 = try! Data(contentsOf: url2)
            let decode = JSONDecoder()
            let jsonData2 = try! decode.decode(JSONData.self, from:data2)
            self.songs = jsonData2.songs
    }
    
}

struct JSONData : Decodable {
    let keys: [Key]
    let songs: [Song]
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
        ])],
        songs:[Song(id: 1, name: "Heart Shaped Box", key: "A")]
     )
    }
}
