import Quickshell
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import "../../Constants.js" as Const

Rectangle {
        width: mainRow.implicitWidth
        height: 40
        anchors.verticalCenter: parent.verticalCenter
        radius: height/2
        color: Const.color.background
        HoverHandler {
                id: mainHoverHandler
        }
        RowLayout {
                id: mainRow
                anchors.fill: parent
                spacing: 3
                Item {}
                Rectangle {
                        id: albumArtRectangle
                        height:  34
                        width: height
                        radius: height/2
                        anchors.centerIn: parent
                        Image {
                                source: Mpris.players.values[0].trackArtUrl
                                height: parent.height
                                width: parent.width
                                layer.enabled: true
                                layer.effect: OpacityMask { maskSource: albumArtRectangle }
                                NumberAnimation on rotation{
                                        from: 0
                                        to: 360
                                        duration: 5000
                                        loops: Animation.Infinite
                                        paused: !Mpris.players.values[0].isPlaying
                                }
                        }
                        MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                        Mpris.players.values[0].togglePlaying()
                                }
                        }
                }
                Item {}
        }
}
