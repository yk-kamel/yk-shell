import Quickshell
import QtQuick
import Quickshell.Services.Pipewire
import QtQuick.Layouts
import "../../Constants.js" as Const

Rectangle {
        height: 40
        width: mainRow.implicitWidth
        radius: height
        color: Const.color.background
        clip: true
        Behavior on width { NumberAnimation { duration: 150; easing.type: Qt.InQuad } }
        HoverHandler { id: mainHoverHandler }
        RowLayout {
                id: mainRow
                anchors.fill: parent
                layoutDirection: Qt.RightToLeft
                Rectangle {
                        height: 30
                        width: 30
                        radius: width/2
                        color: Const.color.accent3
                        Layout.rightMargin: 5
                        Layout.leftMargin: mainHoverHandler.hovered ? 0 : 5
                        MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {  Pipewire.defaultAudioSink.audio.muted = !Pipewire.defaultAudioSink.audio.muted }
                                scrollGestureEnabled: true
                                onWheel: (wheel)=> { Pipewire.defaultAudioSink.audio.volume = Pipewire.defaultAudioSink.audio.volume + (0.05 * wheel.angleDelta.y/120) }
                        }
                        Text {
                                text: Pipewire.defaultAudioSink.audio.muted ? "󰝟"
                                : ( currentVolume > 66 ) ? "󰕾"
                                : ( currentVolume > 33 ) ? "󰖀"
                                : "󰕿"
                                color: Const.color.accent2
                                font.family: Const.font.font1
                                font.pointSize: 14
                                anchors.centerIn: parent
                        }
                }
                Rectangle {
                        visible: mainHoverHandler.hovered
                        height: 32
                        width: 3
                        radius: width/2
                        color: Const.color.accent2
                }
                Repeater {
                        model: appAudio.linkGroups
                        Rectangle {
                                visible: mainHoverHandler.hovered
                                height: 30
                                width: 30
                                radius: width/2
                                color: Const.color.accent3
                                Layout.leftMargin: 5
                                MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: {  modelData.source.audio.muted = !modelData.source.audio.muted }
                                        scrollGestureEnabled: true
                                        onWheel: (wheel)=> { modelData.source.audio.volume = modelData.source.audio.volume + (0.05 * wheel.angleDelta.y/120) }
                                }
                                Text {
                                        text: modelData.source.audio.muted ? "󰝟"
                                        : ( secondaryVolume > 66 ) ? "󰕾"
                                        : ( secondaryVolume > 33 ) ? "󰖀"
                                        : "󰕿"
                                        color: Const.color.accent2
                                        font.family: Const.font.font1
                                        font.pointSize: 14
                                        anchors.centerIn: parent
                                }
                                PwObjectTracker {
                                        objects: [ modelData.source ]
                                }
                                property int secondaryVolume: Math.round( modelData.source.audio.volume * 100 )
                        }
                }
        }
        property int currentVolume: Math.round( Pipewire.defaultAudioSink.audio.volume * 100 )
        PwObjectTracker {
                objects: Pipewire.defaultAudioSink
        }
        PwNodeLinkTracker {
                id: appAudio
                node: Pipewire.defaultAudioSink
        }
}
