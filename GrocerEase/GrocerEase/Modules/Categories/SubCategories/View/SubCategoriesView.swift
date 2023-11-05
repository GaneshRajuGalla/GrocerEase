//
//  SubCategoriesView.swift
//  GrocerEase
//
//  Created by Ganesh on 04/11/23.
//

import SwiftUI
import SwiftData

struct SubCategoriesView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var manager: NavigationManager
    @Environment(\.modelContext) var modelContext
    @Bindable var category:Categories
    @State private var searchText:String = ""
    var filteredItems:[SubCategoriesModel]?{
        guard let subCategory = category.subCategory else {return nil}
        if searchText.isEmpty{
            return subCategory
        }
        let filtedCategories = subCategory.compactMap { item in
            let titleQuery = item.typeName?.range(of: searchText,options: .caseInsensitive) != nil
            return titleQuery ? item : nil
        }
        return filtedCategories
    }
    
    
    
    // MARK: - Body
    
    var body: some View {
        ZStack{
            Color.F_6_F_5_F_5
                .ignoresSafeArea()
            VStack(spacing: 30){
                TextField(String.search, text: $searchText)
                    .modifier(SearchBarView())
                    .padding([.leading,.trailing])
                ScrollView {
                    if let categories = filteredItems{
                        ForEach(categories, id: \.self) { subCategory in
                            NavigationLink(value: Routes.groceryDetail(subCategory)) {
                                subCategoryView(subCategory: subCategory)
                                    .frame(height: 153)
                                    .background(Color.customBg)
                                    .padding(.top,10)
                            }
                            .withCustomEffect()
                        }
                    }
                }
            }
        }
        .navigationTitle(category.categoryType?.localizedLowercase.capitalized ?? "")
        .buttonStyle(PlainButtonStyle())
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            manager.popLast()
        }) {
            Image(systemName: "chevron.left")
                .tint(.black)
        })
        .task {
            if (category.subCategory?.isEmpty ?? false) || (category.subCategory == nil){
                do {
                    let subCategories:[SubCategoriesModel] = try await APIClient.sendRequest(endpoint: .grocerySubCategories(category.categoryType ?? ""))
                    category.subCategory?.append(contentsOf: subCategories)
                } catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension SubCategoriesView{
    
    // TODO: - SubCategoryView
    
    private func subCategoryView(subCategory:SubCategoriesModel) -> some View{
        GeometryReader(content: { geometry in
            HStack(spacing: 20,content: {
                AsyncImageView(urlString: subCategory.thumbnailImage)
                    .frame(width: geometry.size.width * 0.42,height:  geometry.size.height)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading,spacing: 20){
                    Text(subCategory.typeName ?? "")
                        .font(.customFont(family: .roboto, size: .size25))
                        .foregroundStyle(.black)
                        .fontWeight(.medium)
                        .padding(.top,20)
                    
                    HStack{
                        Text(subCategory.pricePerPiece?.toString() ?? "")
                            .font(.customFont(family: .roboto, size: .size18))
                            .foregroundStyle(.black)
                            .fontWeight(.bold)
                        
                        Text(" $/Piece")
                            .font(.customFont(family: .roboto, size: .size15))
                            .foregroundStyle(.black)
                            .fontWeight(.regular)
                    }
                    Spacer()
                }
            })
        })
    }
}
