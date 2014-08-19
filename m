Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:33981 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289AbaHSRUv (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Aug 2014 13:20:51 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCHv2 bluetooth 0/5] mac802154: ieee802154: stable patches
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1408467812-30483-1-git-send-email-alex.aring@gmail.com>
Date: Tue, 19 Aug 2014 12:20:36 -0500
Content-Transfer-Encoding: 7bit
Message-Id: <36287626-7FA7-459F-BB4F-B6E94E517694@holtmann.org>
References: <1408467812-30483-1-git-send-email-alex.aring@gmail.com>
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
> changes v2:
> - remove ieee802154_lowpan in lowpan_frag_rcv to avoid compiler warning
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
> net/ieee802154/reassembly.c            | 15 +++------------
> net/mac802154/wpan.c                   |  6 +++++-
> 4 files changed, 10 insertions(+), 16 deletions(-)

I have applied this series to bluetooth tree now.

Regards

Marcel

