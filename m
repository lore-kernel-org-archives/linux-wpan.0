Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:59424 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932486AbeENPWX (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 14 May 2018 11:22:23 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: net: ieee802154: 6lowpan: fix frag reassembly
Message-ID: <142208d4-6ca6-5923-327c-8d1cb069ceb8@osg.samsung.com>
Date: Mon, 14 May 2018 17:22:18 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Aring <aring@mojatatu.com>, "David S. Miller" <davem@davemloft.net>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, Network Development <netdev@vger.kernel.org>

Hello.


Please apply f18fa5de5ba7f1d6650951502bb96a6e4715a948

(net: ieee802154: 6lowpan: fix frag reassembly) to the 4.16.x stable tree.


Earlier trees are not needed as the problem was introduced in 4.16.


Normally net/ patches would come through DaveM, but he asked me for this one to submit it directly when i sent him the pull request.


First time stable request on my side here, let me know if I got something wrong.


regards

Stefan Schmidt

