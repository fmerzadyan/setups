@file:Suppress("ClassName", "MemberVisibilityCanBePrivate", "unused")

import android.content.Intent
import android.util.Log
import java.util.*

object f {
    private const val TAG = "frankie.and.one"

    @JvmStatic private fun printStackTrace(msg: String?) {
        var callerClass = "<callerClass>"
        var callerMethod = "<callerMethod>"

        val stackTraceElements = Thread.currentThread().stackTrace
        for (i in 1 until stackTraceElements.size) {
            val element = stackTraceElements[i]
            if (element.className != f::class.java.name && element.className.indexOf("java.lang.Thread") != 0) {
                val classname = element.className
                callerClass =
                    if (classname.lastIndexOf(".") != -1) {
                        classname.substring(classname.lastIndexOf(".") + 1)
                    } else {
                        classname
                    }
                callerMethod = element.methodName
                break
            }
        }
        Log.d(
            TAG, if (msg != null) {
                "$callerClass #$callerMethod $msg"
            } else {
                "$callerClass #$callerMethod"
            }
        )
    }

    @JvmStatic fun log(msg: String) {
        printStackTrace(msg)
    }

    @JvmStatic
    fun log(msgs: Array<out String>) {
        msgs.forEach {
            log(it)
        }
    }

    @JvmStatic
    fun log(msg: Int) {
        printStackTrace("$msg.")
    }

    @JvmStatic fun log(msgs: IntArray) {
        msgs.forEach {
            log(it)
        }
    }

    @JvmStatic fun log(msg: String, map: Map<*, *>?) {
        if (map == null) {
            printStackTrace("$msg map: null.")
            return
        }

        if (map.entries.isEmpty()) {
            printStackTrace("$msg map.entrySet(): empty.")
        }

        val stringBuilder = StringBuilder()
        stringBuilder.append("map: {")
        for (entry in map.entries) {
            val pair = entry as Map.Entry<*, *>
            stringBuilder.append(" ").append(pair.key).append(":").append(pair.value)
        }
        stringBuilder.append(" }.")
        printStackTrace("$msg $stringBuilder")
    }

    @JvmStatic
    fun log(msg: String, array: Array<Any>?) {
        if (array == null) {
            printStackTrace("$msg array: null.")
            return
        }

        if (array.isEmpty()) {
            printStackTrace("$msg array: empty.")
            return
        }

        val lastIndex = array.size - 1
        val stringBuilder = StringBuilder()
        stringBuilder.append(" [ ")

        var i = 0
        while (true) {
            stringBuilder.append(array[i].toString())
            if (i == lastIndex) {
                printStackTrace(msg + stringBuilder.append(" ]. ").toString())
                return
            }
            stringBuilder.append(", ")
            ++i
        }
    }

    @JvmStatic
    fun log(msg: String, list: ArrayList<*>) {
        log(msg, list.toTypedArray())
    }

    @JvmStatic fun log(intent: Intent?) {
        if (intent == null) {
            printStackTrace("intent: null.")
            return
        }

        if (intent.extras == null) {
            printStackTrace("intent.getExtras(): null.")
            return
        }

        val bundle = intent.extras
        if (bundle!!.keySet().isEmpty()) {
            printStackTrace("intent.getExtras().keySet(): empty.")
            return
        }

        for (key in bundle.keySet()) {
            printStackTrace("key: " + key + " value: " + bundle.get(key))
        }
    }

    @JvmStatic fun log() {
        printStackTrace("")
    }
}