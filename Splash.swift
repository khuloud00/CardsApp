//
//  Splash.swift
//  card
//
//  Created by Asma Mohammed on 18/06/1446 AH.
//

import SwiftUI

struct Splash: View {
    var body: some View {
        ZStack {
            // خلفية الأومبريه تحت كل شيء
            LinearGradient(gradient: .init(colors: [.splashScreen, .background1]), startPoint: .center, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                // الصورة
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 370, height: 370)
                
                // النص
                Text("")
                    .bold()
                    .font(.title)
                    .foregroundColor(.gray)
                    .padding(.top, 20)
                
                Spacer()
            }
        }
    }
}

#Preview {
    Splash()
}
