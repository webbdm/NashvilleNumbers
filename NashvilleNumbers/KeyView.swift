import SwiftUI

struct KeyView: View {
   var key: Key
    
   var body: some View {
    VStack{
        HStack(){
            VStack(){
                Text("Key Of")
                .font(.system(size: 20.0))
                .foregroundColor(.white)
                Text(key.keyName)
                .font(.system(size: 60.0))
                .foregroundColor(.white)
            }
            Spacer()
            Text("Select")
            .font(.title)
            .foregroundColor(.white)
            .padding()
            .overlay(
               RoundedRectangle(cornerRadius: 15)
                   .stroke(Color.white, lineWidth: 3))
        }
        .padding()
        .background(Color.blue)
        .cornerRadius(20)
        .frame(maxWidth: .infinity)
        
        VStack(){
            ForEach(key.notes) { note in
                 HStack(){
                    Text(String(note.number))
                    .frame(alignment: .leading )
                    .font(.system(size: 80.0))
                    .foregroundColor(Color.white)

                Text("-").font(.title)
                Text(note.noteName).font(.system(size: 80.0))
                    .foregroundColor(Color.white)
            }.frame(maxWidth: .infinity)
        }

    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .border(Color.blue)
        
    
    HStack(){
        Text("<")
        Text("Back")
    }.frame(alignment: .leading )
    
    }
    .padding(50)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.red.edgesIgnoringSafeArea(.all))
}
    

}

struct KeyView_Previews: PreviewProvider {
    static var previews: some View {
       KeyView(key: Key(id: 1, keyName: "C", notes: [
                  Note(id:1,number:1,noteName: "C"),
                  Note(id:1,number:1,noteName: "Dm"),
                  Note(id:1,number:1,noteName: "Em"),
                  Note(id:1,number:1,noteName: "F"),
                  Note(id:1,number:1,noteName: "G"),
                  Note(id:1,number:1,noteName: "Am"),
                  Note(id:1,number:1,noteName: "B")
              ]))
    }
}
