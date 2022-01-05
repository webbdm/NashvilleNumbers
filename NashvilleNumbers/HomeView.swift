import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var keys: [Key] = []
    @State var selectedKey : Key? = nil
    @State var showingKey : Bool = false
    
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
    
    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(named: "panel")
        UITabBar.appearance().standardAppearance = tabBarAppearance
    }
    
    var body: some View {
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
                                  Button(action:{
                                      self.selectedKey = key
                                      showingKey.toggle()
                                  }, label:{
                                      Text(key.keyName.replacingOccurrences(of: "b", with: "♭", options: .literal, range: nil)
                                      )
                                      .foregroundColor(Color.white)
                                      .frame(width: 200, height: 320)
                                      .font(.system(size: 100.0))
                                      .background(
                                        Image("note")
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 200, height: 320, alignment: .center)
                                        .blur(radius: 3)
                                        .clipped()
                                      ).cornerRadius(20)
                                  })
                                      .sheet(isPresented: $showingKey, content: {
                                          KeyView(key:selectedKey!)
                                      })
                              }
                          }.frame(minHeight: 325).padding(25)
                       }.frame(maxHeight: .infinity)
                           
                        VStack(spacing: 0){
                          Text("Setlist")
                            .frame(maxWidth: .infinity)
                           .padding(10)
                           .font(.system(size:36.0))
                           .foregroundColor(Color("lightb"))
                           
                        ScrollView(.vertical){
                        ForEach(songs, id: \.self) { song in
                               HStack(alignment: .firstTextBaseline, spacing: 0){
                                    song.name.map(Text.init)
                                       .frame(maxWidth: .infinity, alignment: .leading)
                                       .foregroundColor(.white)
                                Text(song.key ?? "")
                                       .foregroundColor(Color("lightb"))
                               }.padding(EdgeInsets(top: 0, leading: 20, bottom: 1, trailing: 20))
                           }
                        }
                        Spacer()
                        Spacer()
                        Spacer()
                       
                                          
                   }.background(
                       RoundedCornersShape(corners: [.topLeft, .topRight], radius: 35)
                           .fill(Color("panel"))
                           .edgesIgnoringSafeArea(.bottom)
                           
                   ).frame(minWidth: 0, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity, alignment: .topLeading)
                 }.onAppear(perform: readFile)
                           
                }// Z-Stack
              }
    }
    private func readFile(){
              let url = Bundle.main.url(forResource: "keys", withExtension: "json")!
              let data = try! Data(contentsOf: url)
              let decoder = JSONDecoder()
              let jsonData = try! decoder.decode(JSONData.self, from:data)
              self.keys = jsonData.keys
              self.selectedKey = self.keys[0]
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
        HomeView(
                // songs: songs //Song(id: 1, name: "Heart Shaped Box", key: "A")
        ).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
   }
}
