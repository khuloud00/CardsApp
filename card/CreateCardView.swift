import SwiftUI

struct CreateCardView: View {
    // ربط ViewModel مع العرض
    @StateObject private var viewModel = CreateCardViewModel()

    var body: some View {
        VStack {
            // الشريط العلوي
            HStack {
                Button("Cancel") {
                    viewModel.cancelAction()
                }
                .foregroundColor(Color("CustomOrange"))
                .font(.system(size: 18, weight: .semibold))
                
                Spacer()
                
                Text("Create card")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                
                Spacer()
                
                Button("Save") {
                    viewModel.saveAction()
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
                
                TextField("Typing...", text: $viewModel.inputText)
               
                    .font(.system(size: 22))
                    .foregroundColor(.black)
                    .padding(.horizontal, 8)
                    .padding(.top, 8)
                    .frame(height: 300)
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 16)
            
            Spacer()
            
            // شريط الأزرار السفلي
            HStack {
                Spacer()
                
                CircularButton(
                    iconName: "basket",
                    isSelected: viewModel.selectedButton == .basket
                ) {
                    viewModel.selectButton(.basket)
                }
                
                Spacer()
                
                CircularButton(
                    iconName: "cross.case.fill",
                    isSelected: viewModel.selectedButton == .crossCase
                ) {
                    viewModel.selectButton(.crossCase)
                }
                
                Spacer()
                
                CircularButton(
                    iconName: "tray.fill",
                    isSelected: viewModel.selectedButton == .tray
                ) {
                    viewModel.selectButton(.tray)
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

