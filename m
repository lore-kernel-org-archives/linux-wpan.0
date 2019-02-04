Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ed1-f54.google.com ([209.85.208.54]:40338 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfBDTun (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 4 Feb 2019 14:50:43 -0500
Received: by mail-ed1-f54.google.com with SMTP id g22so973221edr.7
        for <linux-wpan@vger.kernel.org>; Mon, 04 Feb 2019 11:50:42 -0800 (PST)
MIME-Version: 1.0
From: Peter Oskolkov <posk@posk.io>
Date: Mon, 4 Feb 2019 11:50:30 -0800
Message-ID: <CAFTs51UE2RbzeVMZ0gJNzikNMzuPKRLTjAUxhvszGM7w02dvgg@mail.gmail.com>
Subject: How to test a 6lowpan patch w/o physical devices?
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>

Hello!

I'd like to change 6lowpan defragmentation
(net/ieee802154/6lowpan/reassembly.c) code to match that of regular
IPv6, as in https://www.spinics.net/lists/netdev/msg546133.html.

However, I don't have a physical Linux/6lowpan setup to test my
changes. Is it possible to create a virtual 6lowpan device/network
inside net namespaces to run tests like these:

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/tree/tools/testing/selftests/net/ip_defrag.c
?

Thanks,
Peter
