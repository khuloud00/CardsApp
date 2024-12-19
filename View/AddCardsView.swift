import SwiftUI

struct AddCardsView: View {
    @StateObject private var AddCardsViewModel = Viewmodel()
    @State private var text: String = ""
    @State private var category: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.background1)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    if AddCardsViewModel.Cards.isEmpty {
                        // حالة الصفحة الفارغة
                        VStack {
                            Spacer()
                            Text("No items available")
                                .font(.headline)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                    } else {
                        // حالة الصفحة المليئة
                        List {
                            ForEach(AddCardsViewModel.Cards) { entry in
                                VStack(alignment: .leading) {
                                    Text(entry.text)  // عرض النص
                                    Text(entry.categry)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                .onTapGesture {
                                    AddCardsViewModel.speakText()  // التحدث بالنص عند الضغط على العنصر
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                    
//                    // إضافة الزر الدائري
//                    CircularButton(iconName: "plus", action: {
//                        AddCardsViewModel.toggleSheet() // وظيفة فتح الشاشة
//                    })
//                    .padding()  // إضافة المسافة حول الزر
                }
                .toolbar {
                    // الزر في يسار الـ NavigationBar
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            AddCardsViewModel.navigateToInstantCardView()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 22))
                                .foregroundColor(Color("CustomOrange"))
                        }
                    }

                    ToolbarItem(placement: .principal) {
                        Text("Add cards")
                            .font(.system(size: 36))
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            AddCardsViewModel.toggleSheet()
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 22))
                                .foregroundColor(Color("CustomOrange"))
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $AddCardsViewModel.navigateToInstantCard) {
                InstantCardView() // التوجه إلى الصفحة الأخرى عند الحاجة
            }
            .sheet(isPresented: $AddCardsViewModel.isSheetPresented) {
                CreateCardView()  // عرض شاشة إضافة العناصر
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}
