//
//  SongsView.swift
//  NashvilleNumbers
//
//  Created by Geoff Webb on 12/19/21.
//  Copyright © 2021 Geoff Webb. All rights reserved.
//

import SwiftUI

struct SetlistView: View {
    var body: some View {
       VStack{
        ZStack {
            Color("bluebg").edgesIgnoringSafeArea(.all)
            Text("Setlist")
              .padding(20)
              .font(.system(size:56.0))
              .foregroundColor(Color("lightb"))
        }
        
        
       }
    }
}

struct SetlistView_Previews: PreviewProvider {
    static var previews: some View {
        SetlistView()
    }
}
