Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:55340 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673AbaIOL5v (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 15 Sep 2014 07:57:51 -0400
Date: Mon, 15 Sep 2014 13:50:21 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v2 bluetooth] 6lowpan: fix incorrect return values in
 lowpan_rcv
Message-ID: <20140915115019.GB13603@omega>
References: <1410514480-9070-1-git-send-email-martin.townsend@xsilon.com>
 <1410514480-9070-3-git-send-email-martin.townsend@xsilon.com>
 <20140915101331.GA10580@omega>
 <5416C8B3.9020302@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5416C8B3.9020302@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org

On Mon, Sep 15, 2014 at 12:08:35PM +0100, Martin Townsend wrote:
> Hi Alex,
> 
...
> > Also here that's too broken here. In lowpan_give_skb_to_devices we have
> > mixed errno and  NET_RX_SUCCESS for the return variable, we need to
> > clean this up. Maybe just return the NET_RX_SUCCESS|NET_RX_DROP return
> > value from netif_rx call.
> ok, shall i just do a
> return lowpan_give_skb_to_devices(skb);
> 
> and then add the code from freeing or consuming the skb in lowpan_give_skb_to_devices?
> 

yes, great idea.

- Alex
