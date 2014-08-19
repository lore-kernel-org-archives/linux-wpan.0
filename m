Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:44029 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbaHSQoS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Aug 2014 12:44:18 -0400
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH bluetooth 0/5] mac802154: ieee802154: stable patches
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1408438983-13892-1-git-send-email-alex.aring@gmail.com>
Date: Tue, 19 Aug 2014 11:44:11 -0500
Content-Transfer-Encoding: 8BIT
Message-Id: <79B561AB-5717-4F81-9725-FDA13BC2A789@holtmann.org>
References: <1408438983-13892-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>, linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> these patches contains patches for the bluetooth branch.
> 
> This series includes memory leak fixes and an errno value fix.
> Also there are two patches for sending and receiving 1280 6LoWPAN packets,
> which makes the IEEE 802.15.4 6LoWPAN stack more RFC compliant.
> 
> - Alex
> 
> Alexander Aring (2):
>  ieee802154: 6lowpan_rtnl: fix correct errno value
>  ieee802154: 6lowpan: ensure of sending 1280 packets
> 
> Martin Townsend (3):
>  mac802154: fixed potential skb leak with mac802154_parse_frame_start
>  ieee802154: mac802154: handle the reserved dest mode by dropping the
>    packet
>  ieee802154: 6lowpan: ensure MTU of 1280 for 6lowpan
> 
> include/net/netns/ieee802154_6lowpan.h |  1 -
> net/ieee802154/6lowpan_rtnl.c          |  4 ++--
> net/ieee802154/reassembly.c            | 13 +++----------
> net/mac802154/wpan.c                   |  6 +++++-
> 4 files changed, 10 insertions(+), 14 deletions(-)

all 5 patches have been applied to bluetooth tree.

However is it possible you introduced a compile warning.

  CC      net/ieee802154/reassembly.o
net/ieee802154/reassembly.c: In function ‘lowpan_frag_rcv’:
net/ieee802154/reassembly.c:358:34: warning: unused variable ‘ieee802154_lowpan’ [-Wunused-variable]
  struct netns_ieee802154_lowpan *ieee802154_lowpan =
                                  ^

Regards

Marcel

