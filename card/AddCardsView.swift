import SwiftUI

struct AddCardsView: View {
    @StateObject private var viewModel = AddCardsViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.background1)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()
                }
                .toolbar {
                    // الزر في يسار الـ NavigationBar
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            viewModel.navigateToInstantCardView()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 22))
                                .foregroundColor(Color("CustomOrange"))
                        }
                    }

                    // النص الرئيسي في منتصف الـ NavigationBar
                    ToolbarItem(placement: .principal) {
                        Text("Add cards")
                            .font(.system(size: 36))
                            .fontWeight(.bold)
                    }

                    // الزر في يمين الـ NavigationBar
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            viewModel.toggleSheet()
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 22))
                                .foregroundColor(Color("CustomOrange"))
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true) // إخفاء زر الرجوع الافتراضي
            .navigationDestination(isPresented: $viewModel.navigateToInstantCard) {
                InstantCardView()
            }
            .sheet(isPresented: $viewModel.isSheetPresented) {
                CreateCardView()
                    .presentationDetents([.large])
            }
        }
    }
}

