import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: window

    property var windowWidth: Math.round(fontMetrics.height * 32.2856)
    property var windowHeight: Math.round(fontMetrics.height * 13.9528)
    property var heightSafeMargin: 15

    minimumWidth: Math.max(windowWidth, mainLayout.Layout.minimumWidth) + mainLayout.anchors.margins * 2
    minimumHeight: Math.max(windowHeight, mainLayout.Layout.minimumHeight) + mainLayout.anchors.margins * 2 + heightSafeMargin
    maximumWidth: minimumWidth
    maximumHeight: minimumHeight
    visible: true
    
    onClosing: {
        hpa.setResult("fail");
    }

    FontMetrics {
        id: fontMetrics
    }

    SystemPalette {
        id: system

        colorGroup: SystemPalette.Active
    }

    Item {
        id: mainLayout

        anchors.fill: parent
        Keys.onEscapePressed: (e) => {
            hpa.setResult("fail");
        }
        Keys.onReturnPressed: (e) => {
            hpa.setResult("auth:" + passwordField.text);
        }
        Keys.onEnterPressed: (e) => {
            hpa.setResult("auth:" + passwordField.text);
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 12

            Item {
                Layout.fillHeight: true
            }

            Label {
              color: palette.windowText
              font.weight: 700
              font.letterSpacing: 1
              font.pointSize: Math.round(fontMetrics.height * 1.2)
              text: "Authentication Required"
              Layout.alignment: Qt.AlignHCenter
              Layout.maximumWidth: parent.width
              elide: Text.ElideRight
              wrapMode: Text.WordWrap
            }

            TextField {
                id: passwordField

                Layout.topMargin: fontMetrics.height / 2
                placeholderText: "Password"
                placeholderTextColor: Qt.darker(palette.text, 1.5)
                Layout.preferredWidth: 300
                Layout.preferredHeight: 40
                Layout.alignment: Qt.AlignHCenter
                horizontalAlignment: TextInput.AlignHCenter
                verticalAlignment: TextInput.AlignVCenter
                color: palette.text
                leftPadding: 16
                rightPadding: 16
                
                background: Rectangle {
                  color: palette.base
                  radius: height / 2
                }
                
                hoverEnabled: true
                persistentSelection: true
                echoMode: TextInput.Password
                focus: true

                Connections {
                    target: hpa
                    function onFocusField() {
                        passwordField.focus = true;
                    }
                    function onBlockInput(block) {
                        passwordField.readOnly = block;
                        if (!block) {
                            passwordField.focus = true;
                            passwordField.selectAll();
                        }
                    }
                }

            }

            Label {
                id: errorLabel

                color: "red"
                font.italic: true
                Layout.topMargin: 0
                text: ""
                Layout.alignment: Qt.AlignHCenter

                Connections {
                    target: hpa
                    function onSetErrorString(e) {
                        errorLabel.text = e;
                    }
                }

            }

            Rectangle {
                color: "transparent"
                Layout.fillHeight: true
            }

            RowLayout {
                Layout.alignment: Qt.AlignRight
                Layout.rightMargin: fontMetrics.height / 2

                Button {
                    id: control2
                    text: "Cancel"
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 36
                    onClicked: (e) => {
                        hpa.setResult("fail");
                    }

                    contentItem: Text {
                      text: control2.text
                      color: palette.buttonText
                      horizontalAlignment: Text.AlignHCenter
                      verticalAlignment: Text.AlignVCenter
                    }

                    background: Rectangle {
                      radius: height / 2
                      color: control2.down ? palette.mid : (control2.hovered ? Qt.lighter(palette.button, 1.2) : palette.button)
                    }
                }

                Button {
                    id: control
                    text: "Authenticate"
                    Layout.preferredWidth: 120
                    Layout.preferredHeight: 36
                    onClicked: (e) => {
                        hpa.setResult("auth:" + passwordField.text);
                    }

                    contentItem: Text {
                      text: control.text
                      color: palette.buttonText
                      horizontalAlignment: Text.AlignHCenter
                      verticalAlignment: Text.AlignVCenter
                    }

                    background: Rectangle {
                      radius: height / 2
                      color: control.down ? palette.mid : (control.hovered ? Qt.lighter(palette.button, 1.2) : palette.button)
                    }

                }

            }

        }

    }

    component Separator: Rectangle {
        color: Qt.darker(window.palette.text, 1.5)
    }

}
