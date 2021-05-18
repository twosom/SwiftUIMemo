//
//  MemoListScene.swift
//  SwiftUIMemo
//
//  Created by Desire L on 2021/05/18.
//
//

import SwiftUI

struct MemoListScene: View {
    @EnvironmentObject var store: MemoStore


    var body: some View {
        NavigationView{
            List(store.list) { memo in
                Text(memo.content)
            }
            .navigationBarTitle("내 메모")
        }
    }
}

class MemoListScene_Previews: PreviewProvider {
    static var previews: some View {
        MemoListScene()
                .environmentObject(MemoStore())
    }

    #if DEBUG
    @objc class func injected() {
        UIApplication.shared.windows.first?.rootViewController =
                UIHostingController(rootView: MemoListScene())
    }
    #endif
}
