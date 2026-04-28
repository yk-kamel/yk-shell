pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

FileView {
        id: root
        path: Qt.resolvedUrl("./SystemFile/metrics.json").toString().replace("file://", "")
        watchChanges: true
        onFileChanged: reload()
        Component.onCompleted: reload()

        property alias settings: metrics
        JsonAdapter {
                id: metrics

                // CPU
                property real cpu_usage: 0
                property real cpu_clock: 0

                // RAM 
                property real ram_total: 0.0
                property real ram_used: 0.0
                property real ram_free: 0.0
                property int ram_usage: 0

                // GPU 
                property string gpu_vendor: ""
                property int gpu_clock: 0

                // VRAM
                property real vram_total: 0.0
                property real vram_used: 0.0
                property real vram_free: 0.0
                property int vram_usage: 0
        }
}
