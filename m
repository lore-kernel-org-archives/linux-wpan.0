Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:59172 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbaJFKmK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Oct 2014 06:42:10 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH wpan-next 1/3] ieee802154: 6lowpan: fix byteorder for frag tag
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1412586052-27299-1-git-send-email-alex.aring@gmail.com>
Date: Mon, 6 Oct 2014 12:42:15 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <A134B4A0-64A0-4E34-8F54-DBAFDC11EB22@holtmann.org>
References: <1412586052-27299-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi Alex,

> This patch fix byteorder issues with fragment tag of generation 802.15.4
> 6LoWPAN fragment header.
> 
> net/ieee802154/6lowpan_rtnl.c:278:54: warning restricted __be16 degrades to integer
> net/ieee802154/6lowpan_rtnl.c:278:18: warning: incorrect type in assignment (different base types)
> net/ieee802154/6lowpan_rtnl.c:278:18:    expected restricted __be16 [usertype] frag_tag
> net/ieee802154/6lowpan_rtnl.c:278:18:    got unsigned short
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> Reported-by: Marcel Holtmann <marcel@holtmann.org>
> ---
> net/ieee802154/6lowpan_rtnl.c | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

