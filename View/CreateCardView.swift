import SwiftUI

struct CreateCardView: View {
    @StateObject private var CreateCardViewModel = Viewmodel()
    @Environment(\.dismiss) var dismiss
    var addCard: (String) -> Void  // تمرير الدالة مباشرة

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
                    if !CreateCardViewModel.inputText.isEmpty {
                        addCard(CreateCardViewModel.inputText)  // استدعاء الدالة
                        dismiss()
                    }
                }
                .foregroundColor(Color("CustomOrange"))
                .font(.system(size: 18, weight: .semibold))
            }
            .padding(.horizontal)
            .padding(.top, 20)

            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.clear.opacity(0.1))

                TextField("Typing...", text: $CreateCardViewModel.inputText)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 10)
            }
            .padding(.horizontal, 16)
            
            Spacer()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}
