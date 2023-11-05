//
//  CategoriesView.swift
//  GrocerEase
//
//  Created by Ganesh on 04/11/23.
//

import SwiftUI
import SwiftData

struct CategoriesView: View {
    
    // MARK: - Properties
    
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var manager: NavigationManager
    @State private var viewModel = CategoriesViewModel()
    private let columns:[GridItem] = Array(repeating: .init(.flexible(),spacing: 32), count: 2)
    
    // MARK: - Body
    
    var body: some View {
        ZStack{
            Color.F_6_F_5_F_5
                .ignoresSafeArea()
            VStack(spacing: 30){
                TextField(String.search, text: $viewModel.searchText)
                    .modifier(SearchBarView())
                    .onChange(of: viewModel.searchText) { oldValue, newValue in
                        viewModel.updateGroceryCategories(searchText: newValue)
                    }
                
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, content: {
                        if let categories = viewModel.groceryCategories{
                            ForEach(categories,id: \.self) { category in
                                NavigationLink(value:Routes.subCategoriesView(category)) {
                                    withAnimation {
                                        gridView(category: category)
                                    }
                                }
                                .withCustomEffect()
                            }
                        }
                    })
                }
            }
            .padding()
        }
        .navigationTitle(String.categories)
        .navigation(path: $manager.categoriesRoutes)
        .task {
            viewModel.modelContext = modelContext
            viewModel.fetchCategoriesFromSwiftData()
            if (viewModel.groceryCategories?.isEmpty ?? false) || (viewModel.groceryCategories == nil){
                await viewModel.getGroceryCategories()
            }
        }
    }
}

extension CategoriesView{
    
    // TODO: - GridView
    
    @ViewBuilder
    private func gridView(category: Categories) -> some View{
        gridItem(category: category)
            .frame(height: 200)
            .shadow(radius: 10)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow(color: Color.black.opacity(0.13), radius: 10, x: 0, y: 5)
        
    }
    
    // TODO: - GridItem
    
    private func gridItem(category: Categories) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                AsyncImageView(urlString: category.categoryImage)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                Rectangle()
                    .fill(Color.white)
                    .frame(height: geometry.size.height * 0.5)
                
                HStack{
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(category.categoryName ?? "")
                            .font(.customFont(family: .roboto, size: .size18))
                            .foregroundStyle(.black)
                            .fontWeight(.regular)
                        
                        Text("(+\(category.totalItems?.toString() ?? ""))")
                            .font(.customFont(family: .roboto, size: .size10))
                            .foregroundStyle(.gray)
                            .font(.subheadline)
                        Spacer()
                    }
                    Spacer()
                }
                .foregroundStyle(.white)
                .frame(height: geometry.size.height * 0.5)
                .padding(10)
            }
        }
    }
}

#Preview {
    CategoriesView()
}
