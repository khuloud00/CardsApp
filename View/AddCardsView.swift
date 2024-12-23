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
                                    HStack {
                                        Text(entry.text)  // عرض النص
                                        Text(entry.categry)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)

                                        Spacer()

                                        Button(action: {
                                            speakText(entry.text) // تمرير النص الصحيح للدالة
                                        }) {
                                            Image(systemName: "speaker.wave.3.fill")
                                                .resizable()
                                                .frame(width: 25, height: 18)
                                                .foregroundColor(Color("CustomOrange"))
                                                .padding()
                                        }
                                    }
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
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
                CreateCardView(addCard: addCard)  // تمرير الدالة
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            }
        }
    }

    // الدالة لإضافة البطاقة
    private func addCard(text: String) {
        AddCardsViewModel.Cards.append(model(text: text, categry: "Default"))
    }

    // دالة التحدث بالنص
    private func speakText(_ text: String) {
        // قم بتعريف الوظيفة التي تعالج النص لإخراجه كصوت
        print("Speaking text: \(text)") // استبدل هذا بالكود الفعلي للتحدث
    }
}
