import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0 // Use material color palette

Rectangle {
    id: rectangle
    width: 550
    height: 1000

    property string serverIp : "mc.keinett.us"; // This is how you make variables in qml

    // So now we have the UI code in place, now we can make actual requests
    // To get JSON we use javascript in conjuction with the built in function XMLHttpRequest

    function getServerStatus(){
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE) {
                var status = JSON.parse(xhr.responseText); // Parse the responseinto JSON data

                serverStatus_text.text = "Server IP: "+serverIp+"\n"+
                        "Players Online: "+status.players.now+"\n"+
                        "Versions: "+String(status.server.name).substring(11, status.server.name.length);


            }
        }
        xhr.open('GET', "https://mcapi.us/server/status?ip="+serverIp, true);
        xhr.send(null);
    }

    Button { // THis is the login button code
        id: button

        text: qsTr("Sign In")
        visible: true
        anchors.right: parent.right
        anchors.rightMargin: 19
        anchors.top: parent.top
        anchors.topMargin: 10

        // We want a example popup window for now when you click it

        // Button has an event called onClicked:

        onClicked: {
            // Then inside here we open the messagedialog
            // Messagedialog is a separate import which I will now show you

            // Now we have messagedialog imported, somewhere in the file
            // we specify a messagedialog element, outside of the Buttom element

            // Now to open the dialog, it is as simple as follows:

            //loginDialog.open();

            loginRectangle.visible = true;
            loginPopup.open();


            // Now when you click the button, this piece of code runs and opens the dialog box.
        }

    }


    // So now we want to make our own dialog box because the built in MessageDialog is a piece of poop
    // Let's go to the design editor and design a quick box

    // Like right here
    MessageDialog{
        // Message dialog employs two main attributes, title, and text
        // If you want to call an external element, you must associate it with an identifier, or an ID.

        // FOr this dialog we will call it loginDialog

        id: loginDialog // << This is how you specify ID's

        title: "Login" // Title of the dialog
        text: "Hello World" // < Text of the dialog
    }

    Popup{
        id: loginPopup
        modal: true
        dim: true
        x: parent.width / 2
        y: parent.height /2

        Rectangle {
            id: loginRectangle

            width: 311
            height: 246
            color: "#bfbfbf"
            clip: true
            visible: false

            // You can also make rounded corners using radius:

            radius: 5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Text {
                id: text1
                x: 87
                text: qsTr("Login")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 4
                font.pixelSize: 12
            }

            ColumnLayout {
                id: loginColumn
                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                anchors.top: parent.top
                anchors.topMargin: 20

                ColumnLayout {

                    Text {
                        id: text2
                        text: qsTr("Username")
                        font.pixelSize: 12
                    }

                    TextField {
                        id: textInput
                        text: qsTr("Text Input")
                        Layout.fillHeight: false
                        Layout.fillWidth: true

                        font.pixelSize: 12

                        // To set backgrounds of TextFields you use background:
                        background: Rectangle{
                            // Then a color
                            color: "white"
                            radius: 5
                        }
                    }
                }

                ColumnLayout {

                    Text {
                        id: text3
                        text: qsTr("Password")
                        font.pixelSize: 12
                    }

                    TextField {
                        id: textInput1
                        text: qsTr("Text Input")
                        Layout.fillHeight: false
                        Layout.fillWidth: true

                        font.pixelSize: 12

                        // To set backgrounds of TextFields you use background:
                        background: Rectangle{
                            // Then a color
                            color: "white"
                            radius: 5
                        }
                    }
                }

                Button {
                    id: button1
                    text: qsTr("Login")
                    Layout.fillHeight: false
                    Layout.fillWidth: true
                    Layout.preferredHeight: 48
                    Layout.preferredWidth: 184
                    visible: true

                    // We can close the popup here

                    onClicked: {
                        loginRectangle.visible = false;
                        loginPopup.close();
                    }
                }
            }
        }
    }

    Rectangle {
        id: serverStatus
        height: 200
        color: Material.color(Material.BlueGrey, Material.Shade800);
        radius: 10
        visible: true
        clip: true
        anchors.top: parent.top
        anchors.topMargin: 100
        anchors.right: parent.right
        anchors.rightMargin: 50
        anchors.left: parent.left
        anchors.leftMargin: 50

        Text {
            id: serverStatus_title
            x: 212
            color: "#ffffff"
            text: qsTr("Server Status")
            anchors.top: parent.top
            anchors.topMargin: 8
            anchors.horizontalCenter: parent.horizontalCenter
            renderType: Text.NativeRendering
            font.pixelSize: 19
        }

        Text {
            id: serverStatus_text
            color: "white"


            /* Alignment of text */
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap

            text: qsTr("Example Shit")
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.bottomMargin: 10
            anchors.topMargin: 40
            anchors.fill: parent
            font.pixelSize: 12
        }
    }

    Component.onCompleted: {
        getServerStatus();
    }
}
