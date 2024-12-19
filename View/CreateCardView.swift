import SwiftUI

struct CreateCardView: View {
    @StateObject private var CreateCardViewModel = Viewmodel()
    
    @Environment(\.dismiss) var dismiss
   
    var body: some View {
        VStack {
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                .foregroundColor(Color("CustomOrange"))
                .font(.system(size: 18, weight: .semibold))
                
                Spacer()
                
                Text("Create card")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                
                Spacer()
                
                Button("Save") {
                   ////
                    dismiss()
                
                }
                .foregroundColor(Color("CustomOrange"))
                .font(.system(size: 18, weight: .semibold))
            }
            .padding(.horizontal)
            .padding(.top, 20)
            
            // مربع النص مع TextEditor
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.clear.opacity(0.1))
                
                TextField("Typing...", text: $CreateCardViewModel.inputText)
               
                    .foregroundColor(.gray)
                    .padding(.horizontal, 20)                     .multilineTextAlignment(.leading)
                    .padding(.top, 10)
            }
            .padding(.horizontal, 16)
            
            Spacer()
            
            // شريط الأزرار السفلي
            HStack {
                Spacer()
                
                CircularButton(
                    iconName: "basket",
                    isSelected: CreateCardViewModel.selectedButton == .basket
                ) {
                    CreateCardViewModel.selectButton(.basket)
                }
                
                Spacer()
                
                CircularButton(
                    iconName: "cross.case.fill",
                    isSelected: CreateCardViewModel.selectedButton == .crossCase
                ) {
                    CreateCardViewModel.selectButton(.crossCase)
                }
                
                Spacer()
                
                CircularButton(
                    iconName: "tray.fill",
                    isSelected: CreateCardViewModel.selectedButton == .tray
                ) {
                    CreateCardViewModel.selectButton(.tray)
                }
                
                Spacer()
                
            }
            .padding(.bottom, 32)
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
  
    
    }


// معاينة CreateCardView
struct CreateCardView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCardView()
    }
}

