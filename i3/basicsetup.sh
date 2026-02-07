#!/bin/sh

sleep 5

i3-msg workspace I1

i3-msg exec firefox

while ! i3-msg -t get_tree | jq . | grep firefox > /dev/null; do
	sleep 1
done

i3-msg split h

i3-msg exec '/opt/iMeDesktop/iMe -- %u'

while ! i3-msg -t get_tree | jq . | grep iMeDesktop > /dev/null; do
	sleep 1
done

i3-msg [class='firefox'] focus

i3-msg resize set 70ppt

i3-msg split v

i3-msg exec throne
