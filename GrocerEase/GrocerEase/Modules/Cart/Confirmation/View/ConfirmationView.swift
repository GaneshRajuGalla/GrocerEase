//
//  ConfirmationView.swift
//  GrocerEase
//
//  Created by Ganesh on 04/11/23.
//

import SwiftUI
import StripePaymentSheet
import SwiftData

struct ConfirmationView: View {
    
    // MARK: - Properties
    @Environment(\.modelContext) private var modelContext
    @Query var paymentDetails: [PaymentDetails]
    @State var paymentData: PaymentDetails?
    @State private var viewModel = ConfirmationViewModel()
    @State private var isOn:Bool = true
    @EnvironmentObject private var manager:NavigationManager
    @State private var paymentStatusError:String?
    @State private var isPresented:Bool = false
    @Environment(\.presentationMode) var presentationMode
        
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.F_6_F_5_F_5
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 50) {
                    paymentMethodView()
                    deliveryAddressView()
                    deliveryOptionsView()
                    nonContactDeliveryView()
                    if let paymentSheet = viewModel.paymentSheet {
                        PaymentSheet.PaymentButton(paymentSheet: paymentSheet, onCompletion: {result in 
                            switch result {
                            case .completed:
                                UserDefaults.standard.removeObject(forKey: "amount")
                                manager.cartRoutes.append(.paymentSucess)
                            case .canceled:
                                paymentStatusError = .paymentCancelled
                                isPresented = true
                            case .failed:
                                paymentStatusError = .paymentFailed
                                isPresented = true
                            }
                        }) {
                            buttonView(title: .makePayment)
                        }
                    } else {
                        buttonView(title: .loading)
                    }
                }
                .padding()
            }
        }
        .navigationTitle(String.confirmation)
        .navigationBarTitleDisplayMode(.inline)
        .navigation(path: $manager.cartRoutes)
        .alert(isPresented: $isPresented) {
            Alert(
                title: Text(verbatim:paymentStatusError ?? ""),
                dismissButton: .default(Text("Ok"))
            )
        }
        .task {
            await initializeSwiftData()
            await viewModel.sendStartpaymentRequest()
        }
    }
}

extension ConfirmationView{
    
    // TODO: - PaymentMethodView
    
    private func paymentMethodView() -> some View{
        VStack(alignment: .leading,spacing: 34){
            sectionHeaderView(title: .paymentMethod, section: .section1)
            let cardNumber = paymentDetails.first?.cardNum
            sectionRowView(image: .creditCard, option: cardNumber?.maskCreditCard() ?? "")
        }
    }
    
    // TODO: - DeliveryAddressView
    
    private func deliveryAddressView() -> some View{
        VStack(alignment: .leading,spacing: 22){
            sectionHeaderView(title: .deliveryAddress, section: .section2)
            sectionRowView(image: .home, option: paymentDetails.first?.adress ?? "")
        }
    }
    
    // TODO: - DeliveryOptionsView
    
    private func deliveryOptionsView() -> some View{
        VStack(alignment: .leading,spacing: 25){
            sectionHeaderView(title: .deliveryOptions, section: .section3)
            VStack(alignment: .leading,spacing: 25){
                ForEach(viewModel.deliveryOptions, id: \.self) { option in
                    deliveryOption(image: option.image, option: option.option)
                }
            }
        }
    }
    
    // TODO: - NonContactDeliveryView
    
    private func nonContactDeliveryView() -> some View{
        sectionHeaderView(title: .nonContactDeliveries, section: .section4)
    }
    
    // TODO: - SectionHeaderView
    
    private func sectionHeaderView(title:String,section:Sections) -> some View{
        HStack{
            Text(verbatim: title.localizedLowercase.capitalized)
                .font(.customFont(family: .roboto, size: .size22))
                .fontWeight(.bold)
                .foregroundStyle(.black)
            Spacer()
            Button {
                switch section{
                case .section1:
                    if let paymentData = paymentDetails.first{
                        manager.cartRoutes.append(.billing(paymentData))
                    }
                default:
                    return
                }
            } label: {
                if section == .section4{
                    Toggle("",isOn: $isOn)
                        .tint(.B_179_F_7)
                }else {
                    Text(verbatim: .change)
                        .font(.customFont(family: .roboto, size: .size15))
                        .foregroundStyle(._7203_FF)
                        .fontWeight(.bold)
                }
            }
            .withCustomEffect()
        }
    }
    
    // TODO: - SectionRowView
    
    func sectionRowView(image:ImageResource,option:String) -> some View{
        HStack(alignment: .top,spacing: 29){
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 24,height: 24)
            Text(option)
                .font(.customFont(family: .roboto, size: .size17))
                .foregroundStyle(.black)
                .fontWeight(.light)
                .multilineTextAlignment(.leading)
            
        }
    }
    
    // TODO: - DeliveryOption
    
    func deliveryOption(image:ImageResource,option:String) -> some View{
        HStack{
            HStack(alignment: .top,spacing: 29){
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24,height: 24)
                Text(option)
                    .font(.customFont(family: .roboto, size: .size17))
                    .foregroundStyle(paymentDetails.first?.deliveryOption == option ? ._7203_FF : .black)
                    .fontWeight(.light)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
            
            if paymentDetails.first?.deliveryOption == option{
                Image(.check)
                    .resizable()
                    .frame(width: 24,height: 24)
            }
        }
        .onTapGesture {
            paymentDetails.first?.deliveryOption = option
        }
    }
    
    // TODO: - ButtonView
    
    func buttonView(title:String) -> some View{
        Text(verbatim:title)
            .withCustomButton(._0_BCE_83, .white, nil, 15, .borderColor, 1)
            .withCustomEffect()
            .padding([.leading,.trailing], 30)
            .opacity((UserDefaults.standard.value(forKey: "amount") as? Double != 0.0) ? 1.0 : 0.7)
            .disabled(UserDefaults.standard.value(forKey: "amount") as? Double == 0.0)
    }
    
    func initializeSwiftData() async{
        if let paymentData = paymentDetails.first{
            self.paymentData = paymentData
        }else{
            let paymentDetail = PaymentDetails(nameOfTheCard: "Ganesh Raju Galla", adress: .address, cardNum: "4242 4242 4242 4242", expiryDate: "07/26", cvc: "343", deliveryOption:.byDrone, nonContactDelivery: true)
            modelContext.insert(paymentDetail)
            let fetchRequest = FetchDescriptor<PaymentDetails>(predicate: #Predicate{$0.cvc != "343"},sortBy: [SortDescriptor(\.nameOfTheCard)])
            self.paymentData = try? modelContext.fetch(fetchRequest).first
        }
    }
}

enum Sections: Hashable{
    case section1
    case section2
    case section3
    case section4
}
