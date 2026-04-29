import Quickshell
import QtQuick
import Quickshell.Services.Pipewire
import QtQuick.Layouts
import QtQuick.Controls
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
                Repeater {
                        model: Pipewire.nodes.values.filter(node => node.type === PwNodeType.AudioSink)
                        Rectangle {
                                PwObjectTracker { objects: [modelData] }
                                visible: (mainHoverHandler.hovered || Pipewire.preferredDefaultAudioSink == modelData )
                                height: 30
                                width: 30
                                radius: width/2
                                color: Const.color.accent3
                                Layout.leftMargin: 5
                                Layout.rightMargin: 5
                                TapHandler {
                                        cursorShape: Qt.PointingHandCursor
                                        onTapped: { 
                                                Pipewire.preferredDefaultAudioSink = modelData 
                                                for (var key in modelData.properties) { console.log(key + ": " + modelData.properties[key]); }
                                        }
                                }
                                HoverHandler { id: childHover }
                                ToolTip {
                                        x: -width -8
                                        visible: childHover.hovered
                                        text: modelData.properties["node.nick"]
                                        delay: 1000
                                }
                                Text {
                                        text: (Pipewire.preferredDefaultAudioSink == modelData ) ? "󰋌" : "󰋋"
                                        color: Const.color.accent2
                                        font.family: Const.font.font1
                                        font.pointSize: 14
                                        anchors.centerIn: parent
                                }
                        }
                }
                Rectangle {
                        height: 32
                        width: 3
                        radius: width/2
                        color: Const.color.accent2
                }
                Repeater {
                        model: Pipewire.nodes.values.filter(node => node.type === PwNodeType.AudioSource)
                        Rectangle {
                                PwObjectTracker { objects: [modelData] }
                                visible: (mainHoverHandler.hovered || Pipewire.defaultAudioSource.id == modelData.id )
                                height: 30
                                width: 30
                                radius: width/2
                                color: Const.color.accent3
                                Layout.leftMargin: 5
                                Layout.rightMargin: 5
                                TapHandler {
                                        cursorShape: Qt.PointingHandCursor
                                        onTapped: { 
                                                Pipewire.preferredDefaultAudioSource = modelData 
                                        }
                                }
                                HoverHandler { id: childHover }
                                ToolTip {
                                        x: -width -8
                                        visible: childHover.hovered
                                        text: modelData.properties["node.nick"]
                                        delay: 1000
                                }
                                Text {
                                        text: ( Pipewire.defaultAudioSource.id == modelData.id ) ? "󰍬" : "󰍮"
                                        color: Const.color.accent2
                                        font.family: Const.font.font1
                                        font.pointSize: 14
                                        anchors.centerIn: parent
                                }
                        }
                }
        }
}
