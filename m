Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:41305 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752457AbeC0Nq2 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 27 Mar 2018 09:46:28 -0400
Received: by mail-wr0-f172.google.com with SMTP id f14so22470551wre.8
        for <linux-wpan@vger.kernel.org>; Tue, 27 Mar 2018 06:46:27 -0700 (PDT)
From: harrymorris12@gmail.com
Subject: [PATCH 0/1] ieee802154: ca8210: Fix potential security exploit
Date: Tue, 27 Mar 2018 14:45:43 +0100
Message-Id: <20180327134544.16986-1-h.morris@cascoda.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: stefan@osg.samsung.com, aring@mojatatu.com, Harry Morris <h.morris@cascoda.com>

From: Harry Morris <h.morris@cascoda.com>

This patchset fixes a small bug in the ca8210 driver discovered by Domen Puncer Kugler <domen.puncer@samsung.com>.

The bug allows for uninitialised memory to be sent out over SPI by writing unexpected commands to the debug interface. The bug is described in more detail in 1/1.

This fix has been tested on a Raspberry Pi running kernel 4.9.37-v7+:

harry@raspberrypi:~ $ sudo bash -c 'echo -ne "\x4f\x10" > /sys/kernel/debug/ca8210'
bash: line 0: echo: write error: Message too long
harry@raspberrypi:~ $

Harry Morris (1):
  ieee802154: ca8210: fix uninitialised data read

 drivers/net/ieee802154/ca8210.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.11.0

