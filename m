Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:42609 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730308AbfB0T7b (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 27 Feb 2019 14:59:31 -0500
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 0/2] doc: net: ieee802154: move from plain text to rst
Date: Wed, 27 Feb 2019 20:59:12 +0100
Message-Id: <20190227195914.4594-1-stefan@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: davem@davemloft.net, corbet@lwn.net
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-wpan@vger.kernel.org, Stefan Schmidt <stefan@datenfreihafen.org>

Hello.

The ieee802154 subsystem doc was still in plain text. With the networking book
taking shape I thought it was time to do the first step and move it over to rst.
This really is only the minimal conversion. I need to take some time to update
and extend the docs.

The patches are based on net-next, but they only touch the networking book so I
would not expect and trouble. From what I have seen they would go through
Jonathan's tree after being acked by Dave? If you want this patches against a
different tree let me know.

regards
Stefan Schmidt

Stefan Schmidt (2):
  doc: net: ieee802154: introduce IEEE 802.15.4 subsystem doc in rst
    style
  doc: net: ieee802154: remove old plain text docs after switching to
    rst

 .../{ieee802154.txt => ieee802154.rst}        | 193 +++++++++---------
 Documentation/networking/index.rst            |   1 +
 2 files changed, 99 insertions(+), 95 deletions(-)
 rename Documentation/networking/{ieee802154.txt => ieee802154.rst} (58%)

-- 
2.17.2
