Return-Path: <SRS0=eJr/=XX=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737F8C4360C
	for <linux-wpan@archiver.kernel.org>; Sat, 28 Sep 2019 07:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E36D2081B
	for <linux-wpan@archiver.kernel.org>; Sat, 28 Sep 2019 07:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfI1H5q (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 28 Sep 2019 03:57:46 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:52537 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfI1H5q (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 28 Sep 2019 03:57:46 -0400
Received: from localhost.localdomain (p200300E9D742D296A393C26E681B47E6.dip0.t-ipconnect.de [IPv6:2003:e9:d742:d296:a393:c26e:681b:47e6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@sostec.de)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 2CF2BC1B7C;
        Sat, 28 Sep 2019 09:57:44 +0200 (CEST)
From:   Stefan Schmidt <stefan@datenfreihafen.org>
To:     davem@davemloft.net
Cc:     linux-wpan@vger.kernel.org, alex.aring@gmail.com,
        netdev@vger.kernel.org
Subject: pull-request: ieee802154 for net 2019-09-28
Date:   Sat, 28 Sep 2019 09:57:37 +0200
Message-Id: <20190928075737.28132-1-stefan@datenfreihafen.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello Dave.

An update from ieee802154 for your *net* tree.

Three driver fixes. Navid Emamdoost fixed a memory leak on an error
path in the ca8210 driver, Johan Hovold fixed a use-after-free found
by syzbot in the atusb driver and Christophe JAILLET makes sure
__skb_put_data is used instead of memcpy in the mcr20a driver

I switched from branches to tags here to be pulled from. So far not
annotated and not signed. Once I fixed my scripts it should contain
this messages as annotations. If you want it signed as well just tell
me. If there are any problems let me know.

regards
Stefan Schmidt

The following changes since commit f53a7ad189594a112167efaf17ea8d0242b5ac00:

  r8152: Set memory to all 0xFFs on failed reg reads (2019-08-25 19:52:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan.git tags/ieee802154-for-davem-2019-09-28

for you to fetch changes up to 6402939ec86eaf226c8b8ae00ed983936b164908:

  ieee802154: ca8210: prevent memory leak (2019-09-27 21:57:42 +0200)

----------------------------------------------------------------
Christophe JAILLET (1):
      ieee802154: mcr20a: simplify a bit 'mcr20a_handle_rx_read_buf_complete()'

Johan Hovold (1):
      ieee802154: atusb: fix use-after-free at disconnect

Navid Emamdoost (1):
      ieee802154: ca8210: prevent memory leak

 drivers/net/ieee802154/atusb.c  | 3 ++-
 drivers/net/ieee802154/ca8210.c | 2 +-
 drivers/net/ieee802154/mcr20a.c | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)
