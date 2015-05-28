Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33174 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753597AbbE1KCl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 28 May 2015 06:02:41 -0400
Received: by wicmx19 with SMTP id mx19so118314802wic.0
        for <linux-wpan@vger.kernel.org>; Thu, 28 May 2015 03:02:40 -0700 (PDT)
Date: Thu, 28 May 2015 12:02:34 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next] ieee802154: 6lowpan: set ackreq when needed
Message-ID: <20150528100130.GA716@omega>
References: <1432721532-21239-1-git-send-email-alex.aring@gmail.com>
 <5566D03B.7080209@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5566D03B.7080209@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Thu, May 28, 2015 at 10:22:19AM +0200, Stefan Schmidt wrote:
> Hello.
> 
> On 27/05/15 12:12, Alexander Aring wrote:
> >This patch sets the acknowledge request bit inside the 802.15.4 mac
> >header when frame retries is 0 or above. The other frame retries value
> >which is -1 indicates that the transmitter doesn't care about an
> >acknowledge frame which will be ignored after transmitting if the node
> >sends anyway an ack frame after receiving. This is currently unnecessary
> >traffic if the max frame retries parameter is -1. I hope transceivers
> >which supports AACK handling will check on this bit and doesn't send an
> >ack frame after receiving.
> 
> Do we know if AACK enbaled receivers really parse this and avoid sending the
> ACK? They should but I wonder if you did run any test for this.
> 

I did a test with a running at86rf231 in monitor mode, I don't see ack
frames when this isn't set, so AACK handling should take care about this
bit.

Any other suggestions? I mean this patch makes sense, if we are in a
transmit mode that doesn't care about ack frame after transmit, then we
don't need to set the ack request bit, or?

- Alex
