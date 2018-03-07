Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from picapica.im ([88.198.95.67]:37016 "EHLO picapica.im"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754469AbeCGNf1 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 7 Mar 2018 08:35:27 -0500
Date: Wed, 7 Mar 2018 14:35:25 +0100
From: Anton Sviridenko <anton@picapica.im>
Subject: "encryption failed" warnings in dmesg
Message-ID: <20180307133525.GA30047@picapica.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

I send packets through raw socket on ieee802154 network interface using at86rf212b transceiver
and sometimes get lot of these messages in dmesg:

ieee802154 phy0 wpan0: encryption failed: -22

I've traced place in source that generates them:
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/mac802154/tx.c

Can someone explain what happens?
Isn't it supposed for raw packets to be passed as is? I think if packet is encrypted, 
it should be already encrypted by userspace software that prepared this raw packet.
Btw, software that sends raw packets is OpenThread, I'm trying to run it on Linux,
if that matters

How encryption keys are expected to be set up when encryption is used?
It seems wpan-tools do not contain such commands.

Anton

