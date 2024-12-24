//import SwiftUI
//
//struct SheetView: View {
//    @State private var showingSheet = false
//    @State private var textinput = "" // متغير لتخزين النص الذي يكتبه المستخدم
//    @State private var selectedCategory = "middle"
//    
//    var body: some View {
//        Button("Show Sheet") {
//            showingSheet.toggle()
//        }
//        .sheet(isPresented: $showingSheet) {
//            VStack {
//                // HStack للـ Cancel و Save
//                HStack {
//                    Button(action: {
//                        showingSheet = false
//                    }) {
//                        Text("Cancel")
//                            .foregroundColor(Color("CustomOrange"))                             .font(.headline)
//                    }
//                    Spacer()
//                    Button(action: {
//                        // أكشن للحفظ
//                    }) {
//                        Text("Save")
//                            .foregroundColor(Color("CustomOrange"))                           .font(.headline)
//                    }
//                }
//                .padding()
//                
//                // رفع الـ TextField للأعلى
//                Spacer().frame(height: 20)
//                TextField("Typing.....", text: $textinput)
//                    .foregroundColor(.gray)
//                    .padding(.horizontal, 20)                     .multilineTextAlignment(.leading)
//                    .padding(.top, 10) // ارفع أكثر من هنا إن لزم الأمر
//                
//                Spacer() // مسافة للدفع للأسفل
//                HStack(spacing: 30) {
//                    // الزر الأول
//                     Button(action: {
//                        selectedCategory = "left"
//                    }) {
//                        Image(systemName: "basket")
//                            .foregroundColor(selectedCategory == "left" ? .white : Color("CustomOrange"))
//                            .padding()
//                            .frame(width: 100, height: 38)
//                            .background(selectedCategory == "left" ? Color("CustomOrange") : Color.white)
//                            .cornerRadius(30)
//                            .shadow(radius: 2)
//                            .offset(y: -10) // Moves the element up by 10 points
//
//                    }
//
//                    // الزر الأوسط
//                    Button(action: {
//                        selectedCategory = "middle"
//                    }) {
//                        Image(systemName: "case")
//                            .foregroundColor(selectedCategory == "middle" ? .white : Color("CustomOrange"))
//                            .padding()
//                            .frame(width: 100, height: 38)
//                            .background(selectedCategory == "middle" ? Color("CustomOrange") : Color.white)
//                            .cornerRadius(30)
//                            .shadow(radius: 2)
//                            .offset(y: -10) // Moves the element up by 10 points
//                    }
//
//                    // الزر الثالث
//                    Button(action: {
//                        selectedCategory = "right"
//                    }) {
//                        Image(systemName: "tray")
//                            .foregroundColor(selectedCategory == "right" ? .white : Color("CustomOrange"))
//                            .padding()
//                            .frame(width: 100, height: 38)
//                            .background(selectedCategory == "right" ? Color("CustomOrange") : Color.white)
//                            .cornerRadius(30)
//                            .shadow(radius: 2)
//                            .offset(y: -10) // Moves the element up by 10 points
//
//                    }
//                }
//                    .presentationDetents([.fraction(0.75)])
//                    .presentationDragIndicator(.visible)
//            }
//        }
//    }
//}
//#Preview {
//    SheetView()
//}
