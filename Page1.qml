import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0 // Use material color palette

Rectangle {
    id: rectangle
    width: 550
    height: 1000
    color: "#333333"

    property string serverIp : "mc.keinett.us";
    property string knAPI : "http://api.keinett.com/";

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
        xhr.open('GET', "https://mcapi.us/server/status?ip=" + serverIp, true);
        xhr.send(null);
    }

    function getPlayerStats(mcServer, playerName){
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE) {
                var status = JSON.parse(xhr.responseText); // Parse the responseinto JSON data

                if (mcServer == "kc1") {

                }
                if (mcServer == "prison") {

                }
                if (mcServer == "pvp") {

                }
                if (mcServer == "sg") {

                }
                if (mcServer == "skyblock") {

                }
                if (mcServer == "swars") {

                }
                if (mcServer == "xauth") {

                }
            }
        }
        xhr.open('GET', knAPI + mcServer + "/?p=" + playerName, true);
        xhr.send(null);
    }



    // So now we want to make our own dialog box because the built in MessageDialog is a piece of poop
    // Let's go to the design editor and design a quick box

    // Like right here
    Rectangle {
        id: topBar
        height: 69
        color: "#141414"
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        clip: true

        Button { // This is the login button code
            id: button
            x: 466
            y: 10

            text: qsTr("Sign In")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 11
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

        Image {
            id: image
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            anchors.top: parent.top
            anchors.topMargin: 1
            clip: true
            source: "images/logo22.png"
        }
    }

    MessageDialog{
        // Message dialog employs two main attributes, title, and text
        // If you want to call an external element, you must associate it with an identifier, or an ID.

        // FOr this dialog we will call it loginDialog

        id: loginDialog // << This is how you specify ID's

        title: "Login" // Title of the dialog
        text: "Hello World" // < Text of the dialog
    }

    Rectangle {
        z: 5
        id: backgroundPopup
        anchors.fill: parent
        color: "black"
        opacity: 0.5
        visible: false


    }

    Popup{
        z: 10
        id: loginPopup
        modal: true

        dim: false

        x: parent.width / 2
        y: parent.height / 2

        onOpened: {
            backgroundPopup.visible = true;
        }

        onClosed: {
            backgroundPopup.visible = false;
        }

        enter: Transition {
            NumberAnimation { property: "opacity"; from: 0.0; to: 1.0 }
        }

        exit:  Transition {
            NumberAnimation { property: "opacity"; from: 1.0; to: 0.0 }

        }



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
                        text: qsTr("")
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
                        text: qsTr("")
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



    Flickable {
        id: flickable
        y: 69
        height: appWindow.height
        clip: true
        flickableDirection: Flickable.VerticalFlick
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0



        Column{
            anchors.fill: parent
            anchors.margins: 10
            spacing: 20


            Rectangle {
                id: serverStatus

                width: parent.width
                height: 200
                color: "#222222"
                radius: 10
                visible: true
                clip: true


                Text {
                    id: serverStatus_title
                    x: 212
                    color: "#ffffff"
                    text: qsTr("Server Status")
                    font.bold: true
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

                    text: qsTr("loading...")
                    anchors.rightMargin: 10
                    anchors.leftMargin: 10
                    anchors.bottomMargin: 10
                    anchors.topMargin: 40
                    anchors.fill: parent
                    font.pixelSize: 14
                }

                MouseArea {
                    id: serverStatusMouseArea
                    anchors.fill: parent
                    onClicked: {
                        console.log("server status clicked");
                    }
                }
            }

            Rectangle {
                id: lookupPlayer

                width: parent.width
                height: 104
                color: "#222222"
                radius: 10

                Text {
                    id: searchPlayerTect
                    color: "#ffffff"
                    text: qsTr("Search a Player")
                    anchors.top: parent.top
                    anchors.topMargin: 21
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 20
                    anchors.left: parent.left
                    anchors.leftMargin: 64
                    anchors.right: parent.right
                    anchors.rightMargin: 64
                    font.bold: true
                    font.family: "Verdana"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 24
                }

                MouseArea {
                    id: searchPlayerMouseArea
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    onClicked: {
                        console.log("search a player clicked");
                        appWindow.secondPageLoader.source = "PlayerSearch.qml";
                        appWindow.swipeView.setCurrentIndex(1);

                    }
                }
            }

            Rectangle {
                id: placeholder2

                width: parent.width
                height: 104
                color: "#222222"
                radius: 10

                Text {
                    id: placeholderText
                    color: "#ffffff"
                    text: qsTr("Placeholder 2")
                    anchors.top: parent.top
                    anchors.topMargin: 21
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 20
                    anchors.left: parent.left
                    anchors.leftMargin: 64
                    anchors.right: parent.right
                    anchors.rightMargin: 64
                    font.bold: true
                    font.family: "Verdana"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 24
                }

                MouseArea {
                    id: placeholderMouseArea
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    onClicked: {
                        console.log("Placeholder 2 clicked");
                        appWindow.secondPageLoader.source = "Placeholder2.qml";
                        appWindow.swipeView.setCurrentIndex(1);

                    }
                }
            }
        }
    }


    Component.onCompleted: {
        getServerStatus();
    }
}
