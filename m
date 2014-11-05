Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:42839 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbaKEVBx (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 5 Nov 2014 16:01:53 -0500
Date: Wed, 5 Nov 2014 22:01:46 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next] 6lowpan: move skb_free from error paths
 in decompression.
Message-ID: <20141105210143.GA20379@omega>
References: <1415136981-13497-1-git-send-email-mtownsend1973@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1415136981-13497-1-git-send-email-mtownsend1973@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com, marcel@holtmann.org

Hi Martin,

On Tue, Nov 04, 2014 at 09:36:21PM +0000, Martin Townsend wrote:
> Currently we ensure that the skb is freed on every error path in IPHC
> decompression which makes it easy to introduce skb leaks.  By centralising
> the skb_free into the receive function it makes future decompression routines
> easier to maintain.  It does come at the expense of ensuring that the skb
> passed into the decompression routine must not be copied.
> 

I just want to give it a try and want to test it but I got a:

error: patch failed: net/ieee802154/6lowpan_rtnl.c:200
error: net/ieee802154/6lowpan_rtnl.c: patch does not apply ...

while applying.

Is the patch really based on bluetooth-next [0]? Please respin this one if
it doesn't break anything I will ack this one.

- Alex

[0] http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git
