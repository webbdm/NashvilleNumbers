
import SwiftUI

struct HomeView: View {
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
                   VStack(){
                     ZStack {
                       Color("bluebg").edgesIgnoringSafeArea(.all)

                           
                       VStack{
                           HStack{
                               Text("Nashville")
                                   .font(.system(size: 40.0))
                                   .fontWeight(.heavy)
                                   .foregroundColor(.white)
                               Text("Numbers")
                                   .foregroundColor(.white)
                                   .font(.system(size: 40.0))
                                   .fontWeight(.thin)
                           }
                           
                       ScrollView(.horizontal){
                          HStack(spacing: 50){
                              ForEach(keys) { key in
                                      NavigationLink(destination: KeyView(key: key)) {
                                      Text(key.keyName)
                                      .frame(width: 200, height: 320)
                                      .font(.system(size: 100.0))
                                       .foregroundColor(.white)
                                      .fixedSize(horizontal: false, vertical: true)
                                      .multilineTextAlignment(.center)
                                      .padding()
                                      .background(Rectangle().fill(Color("panel")))
                                      .cornerRadius(20)
                                   }
                                  
                              }
                          }.padding(25)
                       }
                           
                       VStack(){
                          Text("Songs")
                           .padding(20)
                           .font(.system(size:56.0))
                           .foregroundColor(Color("lightb"))
                           
                           ForEach(songs) { song in
                               HStack(alignment: .firstTextBaseline, spacing: 175){
                                   Text(song.name)
                                       .frame(maxWidth: .infinity, alignment: .leading)
                                       .foregroundColor(.white)
                                   Text(song.key)
                                       .foregroundColor(Color("lightb"))
                               }.padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                           }
                        Spacer()
                       
                        HStack(spacing: 95){
                            NavigationLink(destination: SongsView(songs: $songs)) {
                                VStack{
                                   Image(systemName: "music.note")
                                  Text("Home").foregroundColor(.white)
                               }
                            }
                            
                            NavigationLink(destination: SongsView(songs: $songs)) {
                                VStack{
                                    Image(systemName: "music.note.list")
                                    Text("Songs").foregroundColor(.white)
                                }
                              }
                            
                            NavigationLink(destination: SetlistView()) {
                            VStack{
                              Image(systemName: "music.note.list")
                              Text("Setlists").foregroundColor(.white)
                                
                            }
                            }
                        }
                           
                                          
                   }.background(
                       RoundedCornersShape(corners: [.topLeft, .topRight], radius: 35)
                           .fill(Color("panel"))
                           .edgesIgnoringSafeArea(.bottom)
                           
                   ).frame(maxHeight:300)
                 }.onAppear(perform: readFile)
                           
               }
                       
               
                       
              }.padding([.top], -50)
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(keys:
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
