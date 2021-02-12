package com.nhancv.nft
import android.os.Build
import android.os.Bundle
import android.view.WindowManager

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        //make transparent status bar
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            window.statusBarColor = 0x00000000
        }
        //Remove full screen flag after load
        window.clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
    }

}
