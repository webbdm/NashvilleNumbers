import SwiftUI

struct ContentView: View {
    
    init() {
       
    }
    
    func tabbarItem(text: String, image: String) -> some View {
        VStack {
            Image(systemName: image)
                .imageScale(.large)
            Text(text)
        }
    }
    
    var body: some View {
           TabView() {
              HomeView().tabItem{
                   self.tabbarItem(text: "Home", image: "music.note")
              }
              SongsView().tabItem{
               self.tabbarItem(text: "Songs", image: "music.note.list")
              }
              SetlistView().tabItem{
               self.tabbarItem(text: "Setlist", image: "music.note.list")
              }
           }
    }
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
       }
    }
}
