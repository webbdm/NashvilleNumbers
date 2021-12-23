//
//  SongsView.swift
//  NashvilleNumbers
//
//  Created by Geoff Webb on 12/19/21.
//  Copyright © 2021 Geoff Webb. All rights reserved.
//

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
            
            VStack(spacing: 150){
                VStack(){
                    Text("Songs")
                    .padding(20)
                    .font(.system(size:56.0))
                    .foregroundColor(Color("lightb"))
                    ForEach(songs) { song in
                        HStack{
                            Text(song.name).foregroundColor(Color(.white))
                            Text(song.key).foregroundColor(Color("lightb"))
                        }
                    }
                }
            HStack{
                VStack{
                    TextField(
                               "Song Name",
                                text: $name
                               )
                               .padding(.all, 20)
                               .background(Color("panel"))
                               .cornerRadius(10)
                               .foregroundColor(.white)
                               
                               TextField(
                                   "Key",
                                   text: $key
                               )
                               .padding(.all, 20)
                               .background(Color("panel"))
                               .cornerRadius(10)
                               .foregroundColor(.white)
                            
                }
                 Button("Add Song", action: add)
              }.padding().background(Color("lightb"))
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
