Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:56191 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbeC1Kyh (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 28 Mar 2018 06:54:37 -0400
Received: by mail-wm0-f49.google.com with SMTP id b127so3238150wmf.5
        for <linux-wpan@vger.kernel.org>; Wed, 28 Mar 2018 03:54:37 -0700 (PDT)
From: harrymorris12@gmail.com
Subject: [PATCH v2 0/1] ieee802154: ca8210: Fix potential security exploit
Date: Wed, 28 Mar 2018 11:54:26 +0100
Message-Id: <20180328105427.34812-1-h.morris@cascoda.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: stefan@osg.samsung.com, aring@mojatatu.com, domen.puncer@samsung.com, Harry Morris <h.morris@cascoda.com>

From: Harry Morris <h.morris@cascoda.com>

v2 to catch length==1 packets or malformed packets read in ca8210_test_check_upstream()

This patchset fixes a small bug in the ca8210 driver discovered by Domen Puncer Kugler <domen.puncer@samsung.com>.

The bug allows for uninitialised memory to be sent out over SPI by writing unexpected commands to the debug interface. The bug is described in more detail in 1/1.

This fix has been tested on a Raspberry Pi running kernel 4.9.37-v7+:

harry@raspberrypi:~ $ sudo bash -c 'echo -ne "\x4f\x10" > /sys/kernel/debug/ca8210'
bash: line 0: echo: write error: Invalid exchange
harry@raspberrypi:~ $

Harry Morris (1):
  ieee802154: ca8210: fix uninitialised data read

 drivers/net/ieee802154/ca8210.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.11.0

