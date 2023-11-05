//
//  BillingView.swift
//  GrocerEase
//
//  Created by Ganesh on 04/11/23.
//

import SwiftUI
import Combine
import SwiftData

struct BillingView: View {
    
    // MARK: - Properties
    @Environment(\.modelContext) var modelContext
    var paymentDetails:PaymentDetails
    @EnvironmentObject private var manager:NavigationManager
    @StateObject private var viewModel:BillingViewModel
    
    // MARK: - Init
    init(paymentDetails: PaymentDetails) {
        self.paymentDetails = paymentDetails
        self._viewModel = StateObject(wrappedValue: BillingViewModel(paymentDetails: paymentDetails))
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.F_6_F_5_F_5
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20){
                    cardLayerView()
                        .frame(maxWidth: .infinity)
                        .frame(height: 240)
                    Image(.camera)
                        .frame(width: 34,height: 29)
                    nameOfTheCardView()
                    cardInputView()
                    dateCVCView()
                    Spacer()
                    buttonView()
                        .frame(width: 243)
                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle(String.creditCard)
        .buttonStyle(PlainButtonStyle())
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            manager.popLast()
        }) {
            Image(systemName: "chevron.left")
                .tint(.black)
        })
    }
}

extension BillingView{
    
    // TODO: - CardLayerView
    
    private func cardLayerView() -> some View{
        ZStack{
            cardViewBg()
            cardDetailsView()
        }
    }
    
    // TODO: - CardViewBg
    
    private func cardViewBg() -> some View{
        RoundedRectangle(cornerRadius: 8)
            .fill(LinearGradient(
                gradient: Gradient(
                    stops: [
                        .init(color: .cardBg1, location: 0.0013),
                        .init(color: .cardBg2, location: 0.0014),
                        .init(color: .cardBg3, location: 0.8017)
                    ]
                ),
                startPoint: .trailing,
                endPoint: .leading
            ))
            .edgesIgnoringSafeArea(.all)
    }
    
    // TODO: - CardNumberView
    
    private func cardDetailsView() -> some View{
        VStack{
            Spacer()
            masterCardView()
            Spacer()
            //Text(viewModel.paymentDetails?.cardNum ?? "")
            Text(viewModel.cardNumber)
                .font(.customFont(family: .roboto, size: .size30))
                .foregroundStyle(.white)
            Spacer()
            HStack{
                Text(viewModel.nameOfTheCard)
                    .font(.customFont(family: .roboto, size: .size20))
                    .fontWeight(.light)
                    .foregroundStyle(.white)
                Spacer()
                Text(viewModel.expiryData)
                    .font(.customFont(family: .roboto, size: .size20))
                    .fontWeight(.light)
                    .foregroundStyle(.white)
            }
            Spacer()
        }
        .padding()
    }
    
    // TODO: - MasterCardView
    
    private func masterCardView() -> some View{
        HStack{
            Spacer()
            Image(.masterCard)
                .resizable()
                .scaledToFit()
                .frame(width: 64,height: 40)
        }
    }
    
    // TODO: - NameOfTheCardView
    
    private func nameOfTheCardView() -> some View{
        VStack(alignment: .leading,spacing: 15){
            Text(verbatim: .nameOfTheCard)
                .font(.customFont(family: .roboto, size: .size14))
                .fontWeight(.light)
                .foregroundStyle(.black)
            
            TextField(String.nameOfTheCard, text: $viewModel.nameOfTheCard)
                .withCustomTextFields()
                .keyboardType(.asciiCapable)
                .onReceive(viewModel.$nameOfTheCard) { _ in viewModel.limitText(for: .nameOfTheCard)}
        }
    }
    
    // TODO: - CardInputView
    
    private func cardInputView() -> some View{
        VStack(alignment: .leading,spacing: 15){
            Text(verbatim: .cardNumber)
                .font(.customFont(family: .roboto, size: .size14))
                .fontWeight(.light)
                .foregroundStyle(.black)
            TextField(String.cardNumber, text: $viewModel.cardNumber)
                .withCustomTextFields()
                .keyboardType(.numberPad)
                .onReceive(Just(viewModel.$cardNumber)) { _ in viewModel.limitText(for: .cardNumber)}
        }
    }
    
    // TODO: - DateCVCView
    
    private func dateCVCView() -> some View{
        HStack(spacing: 22){
            VStack(alignment: .leading,spacing: 15) {
                Text(verbatim: .expiryDate)
                    .font(.customFont(family: .roboto, size: .size14))
                    .fontWeight(.light)
                    .foregroundStyle(.black)
                
                TextField(String.expiryDate, text: $viewModel.expiryData)
                    .withCustomTextFields()
                    .keyboardType(.numberPad)
                    .onChange(of: viewModel.expiryData, { oldValue, newValue in
                        if newValue.count == 2 {
                            if !viewModel.expiryData.contains("/") {
                                viewModel.expiryData.append("/")
                            }
                        }
                    })
                    .onReceive(Just(viewModel.$expiryData)) { _ in viewModel.limitText(for: .expiryData)}
            }
            
            VStack(alignment: .leading,spacing: 15) {
                Text(verbatim: .cvc)
                    .font(.customFont(family: .roboto, size: .size14))
                    .fontWeight(.light)
                    .foregroundStyle(.black)
                
                TextField(String.cvc, text: $viewModel.cvc)
                    .withCustomTextFields(isHint: true)
                    .keyboardType(.numberPad)
                    .onReceive(Just(viewModel.$cvc)) { _ in viewModel.limitText(for: .cvc)}
            }
        }
    }
    
    // TODO: - ButtonView
    
    private func buttonView() -> some View{
        Button {
            updatePaymentDetails()
        } label: {
            Text(verbatim: .useThisCard)
                .withCustomButton(._0_BCE_83, .white, nil, 15, .borderColor, 1)
                .opacity(viewModel.isBtnEnable ? 1.0 : 0.7)
        }
        .disabled(!viewModel.isBtnEnable)
        .withCustomEffect()
    }
    
    func updatePaymentDetails(){
        paymentDetails.nameOfTheCard = viewModel.nameOfTheCard
        paymentDetails.cardNum = viewModel.cardNumber
        paymentDetails.expiryDate = viewModel.expiryData
        paymentDetails.cvc = viewModel.cvc
        manager.popLast()
    }
}
