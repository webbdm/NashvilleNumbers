import SwiftUI
import CoreData

struct SongsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var name: String = ""
    @State private var key: String = ""
    @State var editMode: Bool = false
    @State var showSongAdd: Bool = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Song.id, ascending: true)],
        animation: .default)
    var songs: FetchedResults<Song>
    
    init(){
        UITableViewCell.appearance().backgroundColor = UIColor(named: "bluebg")
    }
    
    func saveContext() {
      do {
        try viewContext.save()
      } catch {
        print("Error saving managed object context: \(error)")
      }
    }
    
    func setEdit() {
        self.editMode.toggle()
    }
    
    func add(){
        let newSong = Song(context: viewContext)
        newSong.key = key
        newSong.name = name
        
        saveContext()
        
        key = ""
        name = ""
    }
    
    
    func delete(song: Song){
        viewContext.delete(song)
        saveContext()
    }
    
    func addSong() -> some View {
        VStack(){
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        Text("Song Name").foregroundColor(Color("lightb"))
                        TextField("",text: $name)
                            .padding(.all, 0)
                            .foregroundColor(.white)
                        Divider()
                            .frame(height: 1)
                            .padding(.horizontal, 30)
                            .background(Color.gray)
                    }

                    VStack(alignment: .leading){
                       Text("Key").foregroundColor(Color("lightb"))
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0));
                       TextField("",text: $key)
                           .padding(.all, 0)
                           .foregroundColor(.white)
                        Divider()
                            .frame(height: 1)
                            .padding(.horizontal, 30)
                            .background(Color.gray)

                    }
                }.padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0))

            HStack{
                Text("Add Song").foregroundColor(Color("panel"))
                 .font(.system(size:26.0))
                Image(systemName: "plus.circle")
                  .padding().foregroundColor(Color("panel"))
            }.frame(maxWidth: .infinity)
             .padding(15)
             .background(Color("lightb"))
             .cornerRadius(10)
             .onTapGesture(count: 1) {self.add();self.showSongAdd.toggle()}
        }.padding()

        }.frame(maxHeight:.infinity)
            .padding()
            .background(Color("panel")).edgesIgnoringSafeArea(.all)
    }
    
    
    var body: some View {
        VStack{
          ZStack(alignment: .bottom) {
           Color("bluebg").edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 1){
                VStack(){
                    Spacer()
                    HStack{
                    Text("Song")
                        .font(.system(size: 40.0))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    Text("Catalog")
                        .font(.system(size: 40.0))
                        .fontWeight(.thin)
                        .foregroundColor(.white)
                    }
                    Spacer()
                    HStack(){
                        Spacer()
              
                        Text(editMode ? "Done" : "Edit")
                             .font(.system(size: 20))
                             .foregroundColor(Color(.white))
                             .onTapGesture {self.setEdit()}
                             //Image(systemName:"pencil.circle")
                        
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
                    ScrollView(){
                        ForEach(songs, id: \.self) { song in
                            
                            HStack{
                                Text(song.name ?? "")
                                    .foregroundColor(Color(.white))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding().animation(.easeInOut(duration: 2) .delay(1), value:  editMode)
                
                                Image(systemName: "trash")
                                    .opacity(editMode ? 1 : 0)
                                    
                                    .foregroundColor(Color(.red))
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                                    .onTapGesture {
                                        self.delete(song: song)
                                    }.animation(.default)

                                Text(song.key ?? "")
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("panel"))
                                    .frame(maxWidth: 30, maxHeight: .infinity)
                                    .padding()
                                    .background(Color("lightb"))
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("panel"))
                            .cornerRadius(10)
                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                        }
                    }.frame(maxHeight: .infinity).padding(EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 20))
                }.frame(maxHeight: .infinity)
     
            }
              if(editMode){
                  HStack{
                  Text("Add Song")
                  Image(systemName: "chevron.up")
                      
                  
                  }.sheet(isPresented: $showSongAdd, content: {
                      addSong()
                   })
                  .padding(10)
                  .background(RoundedCornersShape(corners: [.topLeft, .topRight], radius: 35).fill(Color("lightb")))
                  .foregroundColor(Color("panel"))
                  //.edgesIgnoringSafeArea(.bottom)
                  .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                      .gesture(DragGesture(minimumDistance: 1, coordinateSpace: .local)
                               .onEnded{_ in self.showSongAdd.toggle() })
              }else{EmptyView()}
                  
          }
       }
    }
}

extension PersistenceController {
    static var storeForSongs: PersistenceController{
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        for _ in 0..<10 {
            let song = Song(context: viewContext)
            song.name = "Song Name"
            song.key = "E"
        }

        try! viewContext.save()
        return result
    }
}

struct SongsView_Previews: PreviewProvider {
    static var previews: some View {
       return SongsView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
