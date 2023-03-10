package br.com.exemplo.androidnativo

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

class MainActivity : AppCompatActivity() {
    companion object {
        const val engineId = "fEngine"
    }

    private lateinit var flutterEngine: FlutterEngine

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        flutterEngine = FlutterEngine(this)

        flutterEngine.navigationChannel.setInitialRoute("/pagecrypto")
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )

        FlutterEngineCache.getInstance()
            .put(engineId, flutterEngine)
    }

    fun onStartFlutterActivity(view: View) {
        startActivity(
            FlutterActivity.createDefaultIntent(this)
        )
    }

    fun onStartActivity2(view: View) {
        startActivity(
            FlutterActivity.withNewEngine()
                .initialRoute("/pagewebview")
                .build(this@MainActivity)
        )
    }

    fun onStartActivity3(view: View) {
        startActivity(
            FlutterActivity
                .withCachedEngine(engineId)
                .build(this)
        )
    }

}