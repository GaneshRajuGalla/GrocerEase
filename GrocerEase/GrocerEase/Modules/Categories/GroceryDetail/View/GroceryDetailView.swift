//
//  GroceryDetailView.swift
//  GrocerEase
//
//  Created by Ganesh on 04/11/23.
//

import SwiftUI

struct GroceryDetailView: View {
    
    // MARK: - Properties
    
    @State private var viewModel:GroceryDetailViewModel
    @EnvironmentObject var manager: NavigationManager
    @State private var isLiked:Bool = false
    @AppStorage("amount") var amount:Double?
    
    // MARK: - Init
    
    init(subCategoriesModel: SubCategoriesModel) {
        self.viewModel = GroceryDetailViewModel(subCategoriesModel: subCategoriesModel)
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack{
            if let model = viewModel.subCategoriesModel{
                TabView {
                    ForEach(model.sliderImages ?? [], id: \.self){ image in
                        AsyncImageView(urlString: image)
                            .ignoresSafeArea()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .id(UUID())
                .tabViewStyle(.page(indexDisplayMode: .always))
                .allowsHitTesting(true)
            }
        }
        .navigationBarBackButtonHidden(true)
        .sheet(item: $viewModel.subCategoriesModel) {
            manager.popLast()
        } content: { _ in
            detailView()
                .presentationCornerRadius(50)
                .presentationDetents([.medium])
                .presentationBackground(.EEEEEE)
        }
    }
}

extension GroceryDetailView{
    
    // TODO: - DetailView
    private func detailView() -> some View{
        VStack(alignment: .leading,spacing: 10){
            Spacer()
            Text(viewModel.subCategoriesModel?.typeName ?? "")
                .font(.customFont(family: .roboto, size: .size30))
                .foregroundStyle(.black)
                .fontWeight(.bold)
            
            HStack(spacing: 10){
                Text(viewModel.subCategoriesModel?.pricePerPiece?.toString() ?? "")
                    .font(.customFont(family: .roboto, size: .size30))
                    .foregroundStyle(.black)
                    .fontWeight(.bold)
                
                Text(" $/Piece")
                    .font(.customFont(family: .roboto, size: .size27))
                    .foregroundStyle(.black)
                    .fontWeight(.light)
            }
            
            Text("~\(viewModel.subCategoriesModel?.weightPerPiece?.toString() ?? "") gr/ piece")
                .font(.customFont(family: .roboto, size: .size17))
                .foregroundStyle(._0_BCE_83)
                .fontWeight(.regular)
            
            Text(viewModel.subCategoriesModel?.typeName ?? "")
                .font(.customFont(family: .roboto, size: .size25))
                .foregroundStyle(.black)
                .fontWeight(.bold)
            
            Text(viewModel.subCategoriesModel?.descripton ?? "")
                .font(.customFont(family: .roboto, size: .size18))
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            HStack(spacing: 28){
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.white)
                    Button {
                        withAnimation {
                            isLiked.toggle()
                        }
                    } label: {
                        Image(isLiked ? .linked : .unliked)
                            .resizable()
                            .frame(width: 15,height: 15)
                            .scaledToFit()
                            .padding()
//                            .background(Color.white)
//                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                }
                .frame(width: 80)
                .withCustomEffect()
                
                Button {
                    withAnimation {
                        manager.popToRoot()
                        manager.selectedTab = .cart
                        amount = viewModel.subCategoriesModel?.pricePerPiece
                    }
                } label: {
                    Text(verbatim: .addToCart)
                        .withCustomButton(._0_BCE_83, .white, .shoppingCart, 15, .borderColor, 1)
                }
                .withCustomEffect()
            }
            .frame(height: 46)
        }
        .padding()
    }
}

