import SwiftUI

struct CreateCardView: View {
    @StateObject private var CreateCardViewModel = Viewmodel()
    @Environment(\.dismiss) var dismiss
    var addCard: (String) -> Void  // تمرير الدالة مباشرة
    @State private var selectedCategory = "middle"

    var body: some View {
        VStack {
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                .foregroundColor(Color("CustomOrange"))
                .font(.system(size: 18, weight: .semibold))
                
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
                    .foregroundColor(.black1)
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 10)
                
            }
            .padding(.horizontal, 16)

            // حرك الأزرار تحت TextField ليكونوا فوق الكيبورد
            HStack(spacing: 30) {
                // الزر الأول
                Button(action: {
                    selectedCategory = "left"
                }) {
                    Image(systemName: "basket")
                        .foregroundColor(selectedCategory == "left" ? .white : Color("CustomOrange"))
                        .padding()
                        .frame(width: 100, height: 38)
                        .background(selectedCategory == "left" ? Color("CustomOrange") : Color.white)
                        .cornerRadius(30)
                        .shadow(radius: 2)
                        .offset(y: -10) // Moves the element up by 10 points
                }

                // الزر الأوسط
                Button(action: {
                    selectedCategory = "middle"
                }) {
                    Image(systemName: "case")
                        .foregroundColor(selectedCategory == "middle" ? .white : Color("CustomOrange"))
                        .padding()
                        .frame(width: 100, height: 38)
                        .background(selectedCategory == "middle" ? Color("CustomOrange") : Color.white)
                        .cornerRadius(30)
                        .shadow(radius: 2)
                        .offset(y: -10) // Moves the element up by 10 points
                }

                // الزر الثالث
                Button(action: {
                    selectedCategory = "right"
                }) {
                    Image(systemName: "tray")
                        .foregroundColor(selectedCategory == "right" ? .white : Color("CustomOrange"))
                        .padding()
                        .frame(width: 100, height: 38)
                        .background(selectedCategory == "right" ? Color("CustomOrange") : Color.white)
                        .cornerRadius(30)
                        .shadow(radius: 2)
                        .offset(y: -10) // Moves the element up by 10 points
                }
            }
            .padding(.bottom, 20) // هذا لإبعاد الأزرار عن الكيبورد في الأسفل
            
            Spacer()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}
