Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:35898 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715AbbBBTxd (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Feb 2015 14:53:33 -0500
Received: by mail-we0-f171.google.com with SMTP id k11so38719671wes.2
        for <linux-wpan@vger.kernel.org>; Mon, 02 Feb 2015 11:53:31 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-misc] website: add note about sniffing frontend on host side
Date: Mon,  2 Feb 2015 20:53:14 +0100
Message-Id: <1422906794-20410-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch adds a little note how to start a wireshark frontend on the
host side and pipe all traffic through a ssh connection.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 website/index.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/website/index.txt b/website/index.txt
index 4aaaab7..7331534 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -98,6 +98,14 @@ iwpan phy wpan-phy0 interface add monitor%d type monitor
 ---------------------------------------------------------------------
 
 Then bring this interface up and run wireshark, tcpdump, etc... on it.
+Running a wireshark as sniffing frontend on the $HOST and connect to a $TARGET like Raspberry Pi which have some ethernet ssh connection, you can try:
+
+---------------------------------------------------------------------
+ssh root@$TARGET 'tshark -i monitor0 -w -' | wireshark -k -i -
+---------------------------------------------------------------------
+
+This will pipe all sniffing frames from $TARGET side to $HOST running wireshark application.
+Note you need maybe to change the "$TARGET" and "montior0" to your settings.
 
 //////
 Foren6
-- 
2.2.2

