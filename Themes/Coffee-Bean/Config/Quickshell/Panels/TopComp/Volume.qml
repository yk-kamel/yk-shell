import Quickshell
import QtQuick
import Quickshell.Services.Pipewire
import QtQuick.Layouts
import "../../Constants.js" as Const

Rectangle {
        width: mainRow.implicitWidth
        MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.MiddleButton | Qt.RightButton
                onClicked: (mouse)=> {
                        if (mouse.button == Qt.MiddleButton)
                        visibility = !visibility 

                }
        }
        height: 40
        anchors.verticalCenter: parent.verticalCenter
        radius: height/2
        color: Const.color.background
        PwObjectTracker {
                objects: Pipewire.defaultAudioSink
        }
        PwNodeLinkTracker {
                id: audioAppOutputTracker
                node: Pipewire.defaultAudioSink
        }
        property bool visibility: false
        readonly property int currentVolume : Math.round( Pipewire.defaultAudioSink.audio.volume * 100)
        RowLayout {
                id: mainRow
                anchors.fill: parent
                spacing: 5
                Item {
                        width: 5
                }
                Repeater {
                        model:  audioAppOutputTracker.linkGroups
                        Rectangle {
                                visible: visibility
                                readonly property int secondaryVolume : Math.round( modelData.source.audio.volume * 100)
                                height: 23
                                width: height
                                radius: 7
                                color: Const.color.accent3
                                Text {
                                        text: modelData.source.audio.muted ? "󰝟"
                                        : ( secondaryVolume >= 66) ? "󰕾"
                                        : ( secondaryVolume >= 33) ? "󰖀"
                                        : "󰕿"
                                        anchors.left: parent.left
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.leftMargin: 5
                                        color: Const.color.accent2
                                        font.family: Const.font.font1
                                        font.pointSize: 12
                                }
                                MouseArea {
                                        anchors.fill: parent
                                        onClicked: (mouse) => {
                                                modelData.source.audio.muted = !modelData.source.audio.muted
                                        }
                                }
                                PwObjectTracker {
                                        objects: [modelData.source]
                                }
                        }
                }
                Rectangle {

                        visible: visibility
                        width: 2
                        height: 27
                        color: Const.color.accent2
                        radius: 4
                }
                Rectangle {
                        height: 25
                        width: height
                        radius: 7
                        color: Const.color.accent3
                        Text {
                                text: Pipewire.defaultAudioSink.audio.muted ? "󰝟"
                                : ( currentVolume >= 66) ? "󰕾"
                                : ( currentVolume >= 33) ? "󰖀"
                                : "󰕿"
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.leftMargin: 5
                                color: Const.color.accent2
                                font.family: Const.font.font1
                                font.pointSize: 14
                        }
                        MouseArea {
                                anchors.fill: parent
                                onClicked: (mouse) => {
                                        Pipewire.defaultAudioSink.audio.muted = !Pipewire.defaultAudioSink.audio.muted
                                }
                        }
                }
                Item {
                        width: 5
                }
        }

}
