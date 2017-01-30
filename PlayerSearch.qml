import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Styles 1.4

Rectangle {
    width: 550
    height: 1000
    color: "#333333"
    anchors.fill: parent

    property string knAPI : "http://api.keinett.com/";
    property variant kc1Ranks : ['default', 'member', 'builder', 'architect', 'chatmod', 'moderator', 'admin'];
    property variant prisonRanks : ['default', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'free'];

    function isPlayer(playerName) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE) {
                var status = JSON.parse(xhr.responseText);

                if (status.success === "false") {
                    return false;
                }
                if (status.success === "true") {
                    return true;
                }

            }
        }
        xhr.open('GET', knAPI + "xauth" + "/?p=" + playerName, true);
        xhr.send(null);
    }

    function getPlayerStats(mcServer, playerName) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE) {
                var status = JSON.parse(xhr.responseText); // Parse the responseinto JSON data

                if (mcServer == "kc1") {
                    text8.text = "KC1 Rank: " + status.ranks;
                }
                if (mcServer == "prison") {
                    text7.text = "Prison Rank: " + status.ranks;
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
                    text1.text = "Stats for " + status.user;
                    text3.text = "Last Logged in on " + status.lastlogin;
                    text6.text = "First Joined: " + status.registerdate;

                }
            }
        }
        xhr.open('GET', knAPI + mcServer + "/?p=" + playerName, true);
        xhr.send(null);
    }


    Rectangle {
        id: topBar
        x: 6
        y: -8
        height: 69
        color: "#141414"
        anchors.right: parent.right
        clip: true
        anchors.top: parent.top
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        Button {
            id: button
            x: 466
            y: 10
            text: qsTr("Search")
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottomMargin: 11
            anchors.rightMargin: 19
            anchors.topMargin: 10
            anchors.bottom: parent.bottom
            visible: true
            onClicked: {
                if(textfield_playerSearch.text == "") {
                    noInputDialog.open();
                } else {
                    if (isPlayer(textfield_playerSearch.text) === false) {
                        notPlayerDialog.open();
                    } else {

                        console.log("isplayer: " + isPlayer(textfield_playerSearch.text));
                        playerDataRectangle.visible = true;
                        getPlayerStats("kc1", textfield_playerSearch.text);
                        getPlayerStats("prison", textfield_playerSearch.text);
                        getPlayerStats("pvp", textfield_playerSearch.text);
                        getPlayerStats("sg", textfield_playerSearch.text);
                        getPlayerStats("skyblock", textfield_playerSearch.text);
                        getPlayerStats("swars", textfield_playerSearch.text);
                        getPlayerStats("xauth", textfield_playerSearch.text);

                    }
                }
            }
        }



        TextField {
            id: textfield_playerSearch
            color: "#000000"
            selectionColor: "#00aeef"
            anchors.right: parent.right
            anchors.rightMargin: 234
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 14
            anchors.top: parent.top
            anchors.topMargin: 13
            font.pointSize: 14
            horizontalAlignment: Text.AlignHCenter
            visible: true
            background: Rectangle{
                color: "white"
                radius: 5
            }
        }
        anchors.topMargin: 0
        anchors.left: parent.left
    }

    MessageDialog {
        id: noInputDialog
        standardButtons: StandardButton.Ok
        title: "No input"
        text: "Please input a player name to start a search"
    }
    MessageDialog {
        id: notPlayerDialog
        standardButtons: StandardButton.Ok
        title: "Alert"
        text: "Selected user is not a resgistered player"
    }

    Rectangle {
        id: playerDataRectangle
        x: 0
        y: 70
        width: 550
        height: 930
        color: "#333333"
        visible: false

        Text {
            id: text1
            x: 181
            y: 8
            width: 189
            height: 35
            color: "#ffffff"
            text: qsTr("Stats for ...")
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 20
        }

        Text {
            id: text2
            x: 8
            y: 60
            width: 119
            height: 35
            color: "#ffffff"
            text: qsTr("General")
            font.pixelSize: 18
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            id: text3
            x: 8
            y: 101
            width: 245
            height: 35
            color: "#ffffff"
            text: qsTr("Last logged in on ...")
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 16
            horizontalAlignment: Text.AlignLeft
        }

        Text {
            id: text4
            x: 8
            y: 142
            width: 245
            height: 35
            color: "#ffffff"
            text: qsTr("Staff Member: ...")
            font.pixelSize: 16
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: text5
            x: 8
            y: 183
            width: 245
            height: 35
            color: "#ffffff"
            text: qsTr("VIP/MVP: ...")
            font.pixelSize: 16
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
        }

        Text {
            id: text6
            x: 8
            y: 224
            width: 245
            height: 35
            color: "#ffffff"
            text: qsTr("First Joined: ...")
            font.pixelSize: 16
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
        }

        Text {
            id: text7
            x: 8
            y: 265
            width: 245
            height: 35
            color: "#ffffff"
            text: qsTr("Prison Rank: ...")
            font.pixelSize: 16
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
        }

        Text {
            id: text8
            x: 8
            y: 306
            width: 245
            height: 35
            color: "#ffffff"
            text: qsTr("KC1 Rank: ...")
            font.pixelSize: 16
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
        }
    }

}
