//
// Created by Desire L on 2021/05/18.
//

import SwiftUI

struct ComposeScene: View {
    @EnvironmentObject
    var store: MemoStore

    @State
    private var content: String = ""


    var body: some View {
        NavigationView {
            VStack {
                TextField("", text: $content)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .navigationBarTitle("새 메모", displayMode: .inline)
                    .navigationBarItems(leading: DismissButton(), trailing: SaveButton())
        }
    }
}

fileprivate struct SaveButton: View {
    var body: some View {
        Button(action: {}, label: {
            Text("저장")
        })
    }
}

fileprivate struct DismissButton: View {
    var body: some View {
        Button(action: {}, label: {
            Text("취소")
        })
    }
}

class ComposeScene_Previews: PreviewProvider {
    static var previews: some View {
        ComposeScene()
                .environmentObject(MemoStore())
    }

    #if DEBUG
    @objc class func injected() {
        UIApplication.shared.windows.first?.rootViewController =
                UIHostingController(rootView: MemoListScene())
    }
    #endif
}


