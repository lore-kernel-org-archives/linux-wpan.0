Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:62446 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbaIKISS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 11 Sep 2014 04:18:18 -0400
Date: Thu, 11 Sep 2014 10:18:11 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH][linux-bluetooth 2/3] 6lowpan: Move skb delivery from
 IPHC.
Message-ID: <20140911081808.GA19675@omega>
References: <1410357968-27051-1-git-send-email-martin.townsend@xsilon.com>
 <1410357968-27051-4-git-send-email-martin.townsend@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1410357968-27051-4-git-send-email-martin.townsend@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, Martin Townsend <martin.townsend@xsilon.com>

On Wed, Sep 10, 2014 at 03:06:07PM +0100, Martin Townsend wrote:
> Passing the skb from 6lowpan up to the higher layers is not a
> function of IPHC.  By moving it out of IPHC we also remove the
> need to support error code returns with NET_RX codes.
> It also makes the lowpan_rcv function more extendable as we
> can support more compression schemes.
> 

I will ack this. But please sperate this patch in two. First renaming
the function namens and then removing deliver callback.

btw. The correct tag is bluetooth not linux-bluetooth, or bluetooth-next.



Also this doesn't fix anything? Then this is for bluetooth-next. I know
this depends on the Patch 1/3. Marcel, do you have any a nice solution
about this, that we can deal with huge fixes in bluetooth and new features
for bluetooth-next. Or simple wait when it's merged?

- Alex
