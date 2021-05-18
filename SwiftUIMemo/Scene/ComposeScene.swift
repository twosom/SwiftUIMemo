//
// Created by Desire L on 2021/05/18.
//

import SwiftUI

struct ComposeScene: View {
    @EnvironmentObject
    var store: MemoStore

    @State
    private var content: String = ""

    @Binding
    var showComposer: Bool

    var body: some View {
        NavigationView {
            VStack {
                TextField("", text: $content)
                        .background(Color.yellow)

            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .navigationBarTitle("새 메모", displayMode: .inline)
                    .navigationBarItems(
                            leading: DismissButton(show: $showComposer),
                            trailing: SaveButton(show: $showComposer, content: $content))
        }
    }
}

fileprivate struct SaveButton: View {

    @Binding
    var show: Bool

    @EnvironmentObject
    var store: MemoStore

    @Binding
    var content: String


    var body: some View {
        Button(action: {
            self.store.insert(memo: self.content)

            self.show = false
        }, label: {
            Text("저장")
        })
    }
}

fileprivate struct DismissButton: View {

    @Binding
    var show: Bool

    var body: some View {
        Button(action: {
            self.show = false
        }, label: {
            Text("취소")
        })
    }
}

class ComposeScene_Previews: PreviewProvider {
    static var previews: some View {
        ComposeScene(showComposer: .constant(false))
                .environmentObject(MemoStore())
    }

    #if DEBUG
    @objc class func injected() {
        UIApplication.shared.windows.first?.rootViewController =
                UIHostingController(rootView: MemoListScene())
    }
    #endif
}


