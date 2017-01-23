import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

ApplicationWindow {
    id: appWindow
    visible: true
    width: 550
    height: 1000

    title: qsTr("Keinett")

    property alias secondPageLoader : secondPageLoader
    property alias swipeView: swipeView

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page1 {
            width: appWindow.width
            height: appWindow.height
        }



        Rectangle{
            width: appWindow.width
            height: appWindow.height

            Loader{ anchors.fill: parent; id: secondPageLoader}
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("Menu")
        }
        TabButton {
            text: qsTr("Second")
        }
    }
}
