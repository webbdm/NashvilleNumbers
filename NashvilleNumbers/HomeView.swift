import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var keys: [Key] = []
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Song.id, ascending: true)],
        animation: .default)
    var songs: FetchedResults<Song>

    
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
                                      Text(key.keyName.replacingOccurrences(of: "b", with: "♭", options: .literal, range: nil))
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
                           
                        ScrollView(.vertical){
                        ForEach(songs, id: \.self) { song in
                               HStack(alignment: .firstTextBaseline, spacing: 175){
                                    song.name.map(Text.init)
                                       .frame(maxWidth: .infinity, alignment: .leading)
                                       .foregroundColor(.white)
                                Text(song.key ?? "")
                                       .foregroundColor(Color("lightb"))
                               }.padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                           }
                        }
                        Spacer()
                       
                        HStack(spacing: 95){
                            NavigationLink(destination: SongsView()) {
                                VStack{
                                   Image(systemName: "music.note")
                                  Text("Home").foregroundColor(.white)
                               }
                            }
                            
                            NavigationLink(destination: SongsView()) {
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
      }
      
}

  

struct JSONData : Decodable {
    let keys: [Key]
}

struct HomeView_Previews: PreviewProvider {
    
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Song.name, ascending: true)],
        animation: .default)
    var songs: FetchedResults<Song>
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
        ])]//,
                // songs: songs //Song(id: 1, name: "Heart Shaped Box", key: "A")
        ).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
   }
}
