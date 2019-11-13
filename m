Return-Path: <SRS0=LlXJ=ZF=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D1DC43331
	for <linux-wpan@archiver.kernel.org>; Wed, 13 Nov 2019 12:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A9F21783
	for <linux-wpan@archiver.kernel.org>; Wed, 13 Nov 2019 12:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfKMMiG (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 13 Nov 2019 07:38:06 -0500
Received: from proxima.lasnet.de ([78.47.171.185]:56668 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfKMMiG (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 13 Nov 2019 07:38:06 -0500
Received: from localhost.localdomain (p200300E9D72D8675F75FF946D5804DFB.dip0.t-ipconnect.de [IPv6:2003:e9:d72d:8675:f75f:f946:d580:4dfb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@sostec.de)
        by proxima.lasnet.de (Postfix) with ESMTPSA id A6C9FC1FB6;
        Wed, 13 Nov 2019 13:38:04 +0100 (CET)
From:   Stefan Schmidt <stefan@datenfreihafen.org>
To:     davem@davemloft.net
Cc:     linux-wpan@vger.kernel.org, alex.aring@gmail.com,
        netdev@vger.kernel.org
Subject: pull-request: ieee802154-next 2019-11-13
Date:   Wed, 13 Nov 2019 13:37:59 +0100
Message-Id: <20191113123759.5551-1-stefan@datenfreihafen.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello Dave.

An update from ieee802154 for *net-next*

I waited until last minute to see if there are more patches coming in.
Seems not and we will only have one change for ieee802154 this time.

Yue Haibing removed an unused variable in the cc2520 driver.

Please pull, or let me know if there are any problems.

regards
Stefan Schmidt

The following changes since commit a734d1f4c2fc962ef4daa179e216df84a8ec5f84:

  net: openvswitch: return an error instead of doing BUG_ON() (2019-05-04 01:36:36 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan-next.git tags/ieee802154-for-davem-2019-11-13

for you to fetch changes up to 693463e8340d55af4baed3b0721f9d8f5350a18a:

  ieee802154: remove set but not used variable 'status' (2019-10-28 14:25:46 +0100)

----------------------------------------------------------------
YueHaibing (1):
      ieee802154: remove set but not used variable 'status'

 drivers/net/ieee802154/cc2520.c | 3 ---
 1 file changed, 3 deletions(-)
