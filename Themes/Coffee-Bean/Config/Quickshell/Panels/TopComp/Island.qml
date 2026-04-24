import Quickshell
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import "../../Constants.js" as Const

Rectangle {
        id: mainRectangle
        width: mainRow.implicitWidth
        height: 40
        anchors.centerIn: parent
        radius: height/2
        color: Const.color.background
        HoverHandler {
                id: mainHoverHandler
        }
        WheelHandler {
                id: mainWheelHandler
                acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad

                onWheel: (wheel) => {
                        player = ((player == Mpris.players.values.length - 1) && wheel.angleDelta.y > 0) ? 0
                        : ((player == 0) && (wheel.angleDelta.y < 0)) ? (Mpris.players.values.length - 1)
                        : (player + wheel.angleDelta.y/120)
                        console.log("player", player, "wheel angle", wheel.angleDelta.y, "count", Mpris.players.values.length)
                }
        }
        Behavior on width {
                NumberAnimation {
                        duration: 150
                        easing.type: Easing.InQuad
                }
        }
        RowLayout {
                id: mainRow
                anchors.fill: parent
                anchors.centerIn: parent
                spacing: 3
                Item {}
                Rectangle {
                        height: 34
                        width: height
                        radius: height/2
                        z: 1
                        color: 'transparent'
                        visible: mainHoverHandler.hovered
                        anchors.left: parent.left
                        Text {
                                text: ""
                                color: Const.color.text2
                                font.family: Const.font.font1
                                font.pointSize: 15
                                anchors.centerIn: parent
                        }
                        MouseArea {
                                anchors.fill: parent
                                cursorShape:  Qt.PointingHandCursor
                                onClicked: { Mpris.players.values[player].previous() }
                        }
                } 
                Rectangle {
                        id: albumArtCircle
                        height: 34
                        width: height
                        radius: height/2
                        z: 2
                        anchors.centerIn: parent
                        NumberAnimation on rotation {
                                from: 0
                                to: 360
                                duration: 5000
                                loops: Animation.Infinite
                                paused: !Mpris.players.values[player].isPlaying
                        }
                        MouseArea {
                                anchors.fill: parent
                                cursorShape:  Qt.PointingHandCursor
                                onClicked: { Mpris.players.values[player].togglePlaying() }
                        }
                        Image {
                                source: Mpris.players.values[player].trackArtUrl
                                height: parent.height
                                width: parent.width
                                fillMode: Image.PreserveAspectCrop
                                layer.enabled: true
                                layer.effect: OpacityMask {
                                        maskSource: albumArtCircle
                                }

                        }
                }
                Rectangle {
                        height: 34
                        width: height
                        radius: height/2
                        z: 1
                        color: 'transparent'
                        visible: mainHoverHandler.hovered
                        anchors.right: parent.right
                        Text {
                                text: ""
                                color: Const.color.text2
                                font.pointSize: 15
                                font.family: Const.font.font1
                                anchors.centerIn: parent
                        }
                        MouseArea {
                                anchors.fill: parent
                                cursorShape:  Qt.PointingHandCursor
                                onClicked: { Mpris.players.values[player].next() }
                        }
                } 
                Item {}
        }
        property int player: 0

}
