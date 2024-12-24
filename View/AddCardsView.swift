import SwiftUI

struct AddCardsView: View {
    @StateObject private var AddCardsViewModel = Viewmodel()
    @State private var text: String = ""
    @State private var category: String = ""
    @State private var selectedCards: model? = nil
    @State private var isSheetPresented: Bool = false
    @State private var selectedCategory = "middle"
    
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
                            Image("LogoEmpty")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250)
                            Text("Create Your Own Spoken Card")
                                .font(.title)
                                .foregroundColor(.customOrange)
                                .padding(.top, 20)
                            Spacer()
                        }
                    } else {
                        // أزرار الكاتقوريز هنا
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
                            }
                        }
                        .padding()
                        
                        // قائمة العناصر
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
                                
                                .swipeActions(edge: .leading) {
                                    Button(action: {
                                        selectedCards = entry
                                        isSheetPresented = true
                                    }) {
                                        Image(systemName: "pencil")
                                        Text("Edit")
                                    }
                                    .tint(.blue)
                                }
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive, action: {
                                        if let index = AddCardsViewModel.Cards.firstIndex(where: { $0.id == entry.id }) {
                                            AddCardsViewModel.deleteJCards(at: index)
                                        }
                                    }) {
                                        Image(systemName: "trash")
                                        Text("Delete")
                                    }
                                }
                                
                            }
                            
                        }
                        .scrollContentBackground(.hidden) // إخفاء خلفية `List`
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
                    .presentationDetents([.large])
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
