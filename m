Return-Path: <SRS0=Rh/c=CR=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5F5C433E2
	for <linux-wpan@archiver.kernel.org>; Tue,  8 Sep 2020 17:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 092C82078B
	for <linux-wpan@archiver.kernel.org>; Tue,  8 Sep 2020 17:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgIHRmt (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:42:49 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:48560 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731982AbgIHRma (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 8 Sep 2020 13:42:30 -0400
Received: from PC192.168.2.51.datenfreihafen.local (p200300e9d72b66a2cea394247181a3e4.dip0.t-ipconnect.de [IPv6:2003:e9:d72b:66a2:cea3:9424:7181:a3e4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@sostec.de)
        by proxima.lasnet.de (Postfix) with ESMTPSA id F3EF8C07D3;
        Tue,  8 Sep 2020 19:42:20 +0200 (CEST)
From:   Stefan Schmidt <stefan@datenfreihafen.org>
To:     davem@davemloft.net
Cc:     linux-wpan@vger.kernel.org, alex.aring@gmail.com,
        netdev@vger.kernel.org
Subject: pull-request: ieee802154 for net 2020-09-08
Date:   Tue,  8 Sep 2020 19:42:16 +0200
Message-Id: <20200908174216.461554-1-stefan@datenfreihafen.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello Dave.

An update from ieee802154 for your *net* tree.

A potential memory leak fix for ca8210 from Liu Jian,
a check on the return for a register read in adf7242
and finally a user after free fix in the softmac tx
function from Eric found by syzkaller.

regards
Stefan Schmidt

The following changes since commit 6ef9dcb78046b346b5508ca1659848b136a343c2:

  tipc: allow to build NACK message in link timeout function (2020-07-20 20:11:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan.git tags/ieee802154-for-davem-2020-09-08

for you to fetch changes up to 0ff4628f4c6c1ab87eef9f16b25355cadc426d64:

  mac802154: tx: fix use-after-free (2020-09-08 16:35:32 +0200)

----------------------------------------------------------------
Eric Dumazet (1):
      mac802154: tx: fix use-after-free

Liu Jian (1):
      ieee802154: fix one possible memleak in ca8210_dev_com_init

Tom Rix (1):
      ieee802154/adf7242: check status of adf7242_read_reg

 drivers/net/ieee802154/adf7242.c | 4 +++-
 drivers/net/ieee802154/ca8210.c  | 1 +
 net/mac802154/tx.c               | 8 +++++---
 3 files changed, 9 insertions(+), 4 deletions(-)
