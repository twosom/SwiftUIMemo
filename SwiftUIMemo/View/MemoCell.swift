//
// Created by Desire L on 2021/05/18.
//

import SwiftUI

struct MemoCell: View {

    @ObservedObject
    var memo: Memo

    @EnvironmentObject
    var formatter: DateFormatter


    var body: some View {
        VStack(alignment: .leading) {
            Text(memo.content)
                    .font(.body)
                    .lineLimit(1)

            Text("\(memo.insertDate, formatter: self.formatter)")
                    .font(.caption)
                    .foregroundColor(Color(UIColor.secondaryLabel))
        }
    }
}


struct MemoCell_Previews: PreviewProvider {
    static var previews: some View {
        MemoCell(memo: Memo(content: "Test"))
                .environmentObject(DateFormatter.memoDateFormatter)
    }
}