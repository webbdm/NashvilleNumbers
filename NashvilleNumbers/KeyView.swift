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
        Spacer()
        
        VStack(){
            ForEach(key.notes) { note in
            HStack(){
                Text(String(note.number))
                    .frame(alignment: .leading )
                    .font(.system(size: 60.0))
                    .foregroundColor(Color.white)
                Spacer()
                
                Text("-")
                    .frame(alignment: .leading )
                    .font(.title)
                Spacer()
                
                Text(note.noteName).font(.system(size: 60.0))
                    .foregroundColor(Color.white)
            }.frame(maxWidth: .infinity)
        }

    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .border(Color.blue)
    Spacer()
        
    
//    HStack(){
//        Text("<")
//        Text("Back")
//        Spacer()
//    }
//    .frame(alignment: .leading )
         
        
    
    }
    .padding(.leading,20)
    .padding(.trailing,20)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.red.edgesIgnoringSafeArea(.all))
}
    

}

struct KeyView_Previews: PreviewProvider {
    static var previews: some View {
       KeyView(key:
        Key(id: 1,
            keyName: "C",
            notes: [
                  Note(id:1,number:1,noteName: "C#m"),
                  Note(id:1,number:1,noteName: "Dm"),
                  Note(id:1,number:1,noteName: "Em"),
                  Note(id:1,number:1,noteName: "F"),
                  Note(id:1,number:1,noteName: "G"),
                  Note(id:1,number:1,noteName: "Am"),
                  Note(id:1,number:1,noteName: "B")
              ]))
    }
}
