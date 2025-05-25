//
//  LicensesView.swift
//  Please
//
//  Created by Sophie Brand on 24.05.25.
//

import SwiftUI

struct LicensesView: View {
    var body: some View {
        VStack(spacing: .paddingMedium){
            titleView()
            lincencesTextView()
            Spacer()
        }
    }
    @ViewBuilder
    func titleView()-> some View {
        Text("Lizenzen")
            .multilineTextAlignment(.center)
            .font(.largeBold)
    }
    @ViewBuilder
    func lincencesTextView()-> some View {
        VStack(alignment: .leading, spacing: .paddingMedium){
            Text("Idee, Flaticon, https://www.flaticon.com/de/kostenloses-icon/idee_427735?term=gl%C3%BChbirne&page=1&position=13&origin=search&related_id=427735")
            Text("AI, Flaticon, https://www.flaticon.com/de/kostenloses-icon/ai_8131876?term=ai&related_id=8131876")
            Text("Modell, Flaticon, https://www.flaticon.com/de/kostenloses-icon/modell_1310124")
            Text("Datensammlung, Flaticon, https://www.flaticon.com/de/kostenloses-icon/datensammlung_3270865")
            Text("Tiefes Lernen, Flaticon, https://www.flaticon.com/de/kostenloses-icon/tiefes-lernen_4882508")
        }
        .font(Font.medium)
        .padding(.paddingMedium)
        .foregroundColor(Color.black)
    }
}
