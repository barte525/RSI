//
//  AlertsListView.swift
//  HowMoneyApp
//
//  Created by Aleksandra Generowicz on 13/06/2022.
//

import SwiftUI

struct AlertsListView: View {
    
    let alerts: [String] = []
    @State var searchText: String = ""
    @State var isAlertSet: Bool = false
    var filteredAlerts: [String] {
        return alerts.filter { alertAssetName in
            searchText.isEmpty || alertAssetName.lowercased().contains(searchText.lowercased())
        }
    }
    
    @State private var isEditing: Bool = false
    
    var body: some View {
        ZStack {
            if alerts.count > 0 {
                VStack {
                    HStack {
                        if !isEditing {
                            Image(systemName: "magnifyingglass")
                                .padding(.leading, 5)
                        }
                        
                        TextField("Search", text: $searchText)
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
                        ForEach(0..<filteredAlerts.count, id: \.self) { alertIndex in
                            let alert = filteredAlerts[alertIndex]
                            Text(alert)
                        }
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
                            NewAlertView(isAlertSet: $isAlertSet)
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
            NewAlertView(isAlertSet: $isAlertSet)
        } label: {
            Image(systemName: "plus")
        }
        )
        .alert(isPresented: $isAlertSet) {
            Alert(title: Text("You've set alert"),
                  message: Text("You'll get an email when the target value will be achieved."), dismissButton: .cancel(Text("OK")))
        }
    }
}

struct AlertsListView_Previews: PreviewProvider {
    static var previews: some View {
        AlertsListView()
    }
}
