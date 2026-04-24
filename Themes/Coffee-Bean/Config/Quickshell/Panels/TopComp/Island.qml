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
                                onClicked: { Mpris.players.values[0].previous() }
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
                                paused: !Mpris.players.values[0].isPlaying
                        }
                        MouseArea {
                                anchors.fill: parent
                                cursorShape:  Qt.PointingHandCursor
                                onClicked: { Mpris.players.values[0].togglePlaying() }
                        }
                        Image {
                                source: Mpris.players.values[0].trackArtUrl
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
                                onClicked: { Mpris.players.values[0].next() }
                        }
                } 
                Item {}
        }
}
