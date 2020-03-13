Return-Path: <SRS0=xUNG=46=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC736C10DCE
	for <linux-wpan@archiver.kernel.org>; Fri, 13 Mar 2020 13:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88DA2073E
	for <linux-wpan@archiver.kernel.org>; Fri, 13 Mar 2020 13:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgCMNgh (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:36:37 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:39928 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgCMNgh (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 13 Mar 2020 09:36:37 -0400
Received: from PC192.168.2.50 (p200300E9D702D81DD67DF7ED221BA585.dip0.t-ipconnect.de [IPv6:2003:e9:d702:d81d:d67d:f7ed:221b:a585])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@sostec.de)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 86C5FC31EF;
        Fri, 13 Mar 2020 14:36:34 +0100 (CET)
From:   Stefan Schmidt <stefan@datenfreihafen.org>
To:     davem@davemloft.net
Cc:     linux-wpan@vger.kernel.org, alex.aring@gmail.com,
        netdev@vger.kernel.org
Subject: pull-request: ieee802154-next 2020-03-13
Date:   Fri, 13 Mar 2020 14:36:21 +0100
Message-Id: <20200313133621.11374-1-stefan@datenfreihafen.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello Dave.

An update from ieee802154 for *net-next*

Two small patches with updates targeting teh whole tree.
Sergin does update SPI drivers to the new transfer delay handling
and Gustavo did one of his zero-length array replacement patches.

Please pull, or let me know if there are any problems.

regards
Stefan Schmidt


The following changes since commit 9f6e055907362f6692185c1c9658295d24095c74:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2020-02-27 18:31:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan-next.git tags/ieee802154-for-davem-2020-03-13

for you to fetch changes up to 53cb2cfaa62d122fa9d92398926a6b7e8f052844:

  cfg802154: Replace zero-length array with flexible-array member (2020-02-29 14:39:08 +0100)

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      cfg802154: Replace zero-length array with flexible-array member

Sergiu Cuciurean (1):
      net: ieee802154: ca8210: Use new structure for SPI transfer delays

 drivers/net/ieee802154/ca8210.c | 3 ++-
 include/net/cfg802154.h         | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)
