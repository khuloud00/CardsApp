//
//  Splash.swift
//  card
//
//  Created by Asma Mohammed on 18/06/1446 AH.
//

import SwiftUI

struct Splash: View {
    var body: some View {
        VStack {
            Spacer()
            Image("AppLogo")
                .resizable()
                .scaledToFit()
            Text("Talkie Cards")
                .font(.title)
                .foregroundColor(.gray)
                .padding(.top, 20)
            Spacer()
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    Splash()
}
