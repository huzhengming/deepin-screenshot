import QtQuick 2.1

Item {
    id: toolButton
    width: 30
    height: 28
    state: "off"

    property url dirAction: "../image/action/"
    property url dirActionMenu: "../image/action_menu/"
    property url dirSizeImage: "../image/size/"
    property url dirColor_big: "../image/color_big/"
    property url dirShareImage:"../image/share/"
    property url dirSave: "../image/save/"

    property string imageName: ""
    property string dirImage:dirAction

    property var group: null

    signal pressed()
    signal entered()
    signal exited()
    states: [
            State {
                    name : "on"
                    PropertyChanges {
                        target:toolImage
                        source: toolButton.dirImage + toolButton.imageName + "_press.svg"
                     }
            },
            State {
                    name : "off"
                    PropertyChanges {
                        target:toolImage
                        source: toolButton.dirImage + toolButton.imageName + ".svg"
                    }
        }
    ]

    onStateChanged: if (group&&state == "on") group.checkState(toolButton)

    Rectangle {
        id: selectArea
        anchors.centerIn: parent
        width: 24
        height: 20
        radius: 4
        visible: false

        color: "white"
        opacity: 0.2
    }
    Image {
        id: toolImage
        width: 24
        height: 24
        anchors.centerIn: parent
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: windowView.set_cursor_shape("shape_arrow_mouse")
        onEntered: {
            selectArea.visible = true
            toolImage.source = toolButton.dirImage + toolButton.imageName + "_hover.svg"
            toolButton.entered()
        }

        onExited: {
            selectArea.visible = false
            if (toolButton.state == "on") {
               toolImage.source = toolButton.dirImage + toolButton.imageName + "_press.svg"
            } else {
               toolImage.source = toolButton.dirImage + toolButton.imageName+".svg"
            }
            toolButton.exited()
        }

        onPressed:{
            toolButton.state = toolButton.state == "on" ? "off" : "on"
            toolButton.pressed()
        }
    }
}
