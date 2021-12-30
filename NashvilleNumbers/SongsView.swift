import SwiftUI

struct SongsView: View {
    @State private var name: String = ""
    @State private var key: String = ""
    @Binding var songs: [Song]
    
    func add(){
        songs.append(Song(id: 4, name: name, key: key))
    }
    
    
    var body: some View {
        VStack{
        ZStack {
            Color("bluebg").edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 5){
                VStack(){
                    Text("Songs")
                    .padding(0)
                    .font(.system(size:56.0))
                    .foregroundColor(Color("lightb"))
                    ScrollView{
                        ForEach(songs) { song in
                            HStack{
                                Text(song.name).foregroundColor(Color(.white))
                                Text(song.key).foregroundColor(Color("lightb"))
                            }
                        }
                    }.padding()
                }
            VStack(){
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                    Text("Song Name").foregroundColor(Color("lightb"))
                    TextField("Song Name",text: $name)
                        .padding(.all, 10)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    Divider()
                        .frame(height: 1)
                        .padding(.horizontal, 30)
                        .background(Color.gray)
                   Text("Key").foregroundColor(Color("lightb")).padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                   TextField("Key",text: $key)
                       .padding(.all, 10)
                       .cornerRadius(10)
                       .foregroundColor(.white)
                    Divider()
                        .frame(height: 1)
                        .padding(.horizontal, 30)
                        .background(Color.gray)
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
                 .onTapGesture(count: 2) {self.add()}
            }.padding()
                
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
                
              }.frame(maxHeight:350)
                .padding()
                .background(
                  RoundedCornersShape(corners: [.topLeft, .topRight], radius: 35)
                      .fill(Color("panel"))
                      .edgesIgnoringSafeArea(.bottom)
                      
              )
            }
         }
       }
    }
}

struct SongsView_Previews: PreviewProvider {
    static var previews: some View {
        SongsView(songs: .constant([Song(id: 1, name: "Heart Shaped Box", key: "A")]))
    }
}
