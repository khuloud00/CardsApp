import SwiftUI

struct CircularButton: View {
    var iconName: String
    var isSelected: Bool = false
    var action: () -> Void

    var body: some View {
            
        Button(action: action) {
                  
            Image(systemName: iconName) // صورة الزر
                        .resizable()
                        .frame(width: 34, height: 29) // حجم الصورة
                    // حجم الزر
                        .foregroundColor(isSelected ? .white : .customOrange)
                       
                }
                .frame(width: 100, height: 38)
                .background(isSelected ? .customOrange : .white)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.customOrange)
                    
                )
//                        .onTapGesture {
//                            withAnimation {
//                                isSelected.toggle()
//                            }
//                        }
                }
        
            }
    



