//
//  AlertsListView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 13/06/2022.
//

import SwiftUI

struct AlertsListView: View {
    
    var userMail: String
    @EnvironmentObject var alertViewModel: AlertViewModel
    @State var isAlertSet: Bool = false
    @State private var isEditing: Bool = false
    
    var body: some View {
        ZStack {
            if alertViewModel.alerts.count > 0 {
                VStack {
                    HStack {
                        if !isEditing {
                            Image(systemName: "magnifyingglass")
                                .padding(.leading, 5)
                                .padding([.top, .bottom], 10)
                        }
                        
                        TextField("Search", text: $alertViewModel.searchText)
                            .padding(.leading, 5)
                            .padding([.top, .bottom], 10)
                    }
                    .background(Color("ControlBackground"))
                    .cornerRadius(10)
                    .frame(height: 60)
                    .padding([.leading, .trailing], 15)
                    .onTapGesture {
                        withAnimation {
                            isEditing.toggle()
                        }
                    }
                    
                    List {
                        ForEach(0..<alertViewModel.filteredAlerts.count, id: \.self) { alertIndex in
                            let alert = alertViewModel.filteredAlerts[alertIndex]
                            HStack {
                                Text(alert.asset_name)
                                Spacer()
                                Text(AmountFormatter.getRoundedAmount(for: alert.value))
                                Text(alert.currency)
                            }
                        }
                        .onDelete(perform: deleteAlert)
                    }
                }
            } else {
                VStack {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                        .scaledToFit()
                    Text("You don't have any alerts.")
                        .foregroundColor(Color.primary)
                        .fontWeight(.medium)
                        .padding(.top, 0)
                    HStack {
                        Text("Set alert")
                            .foregroundColor(Color.primary)
                            .fontWeight(.medium)
                            .padding(.top, 0)
                        NavigationLink {
                            NewAlertView(userMail: userMail)
                                .environmentObject(alertViewModel)
                        } label: {
                            Text("here.")
                                .foregroundColor(Color("DarkPurple"))
                                .fontWeight(.semibold)
                                .padding(.top, 0)
                        }
                    }
                    Spacer()
                }
                .padding(.top, 20)
            }
        }
        .padding(.top, 20)
        .navigationBarTitle("Your alerts")
        .navigationBarItems(trailing:
                                NavigationLink {
            NewAlertView(userMail: userMail)
                .environmentObject(alertViewModel)
        } label: {
            Image(systemName: "plus")
        }
        )
        .alert(isPresented: $alertViewModel.isAlertSet) {
            Alert(title: Text("You've set alert"),
                  message: Text("You'll get an email when the target value will be achieved."), dismissButton: .cancel(Text("OK")))
        }
        .onAppear {
            alertViewModel.getAlerts(for: userMail)
        }
    }
    
    private func deleteAlert(indexSet: IndexSet) {
        let alertsToDelete = indexSet.map { alertViewModel.alerts[$0] }
        guard alertsToDelete.count == 1 else {
            return
        }
        alertViewModel.chosenAlertToDelete = alertsToDelete[0]
        alertViewModel.deleteAlert(for: userMail)
    }
}

struct AlertsListView_Previews: PreviewProvider {
    static var previews: some View {
        AlertsListView(userMail: "jan.smith@gmail.com")
    }
}
