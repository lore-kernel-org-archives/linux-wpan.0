Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:23266 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753141AbcLNHUd (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 14 Dec 2016 02:20:33 -0500
Date: Wed, 14 Dec 2016 07:20:24 +0000
From: Xue Wenqian <wsn.iot.xwq@cn.fujitsu.com>
Subject: [wpan-tools issue]wpan-ping: recv() function for receiving wpan-ping
 packets
Message-ID: <20161214072024.GB5190@localhost.localdomain>
Reply-To: wsn.iot.xwq@cn.fujitsu.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: stefan@osg.samsung.com

Hi,

Recently I find a wpan-ping problem: wpan-ping process is always
running, when there is another process runing on wpan interface, which
will also transmit packets via wpan, the non-wpanping packets will also
be received by recv() of wpan-ping, leading to the "Sequence number did
not match" problem. It seems that the recv() function can not filter out
non-wpanping packets.

To avoid the influences of packets transmitted by another process, I add
some codes to do the filtering for wpan-ping client and wpan-ping
server.

Do you consider this as a bug for wpan-ping? If yes, I'll submit the
modification as a new patch for discussion, thank you all!

Best Regards,
Xue Wenqian


