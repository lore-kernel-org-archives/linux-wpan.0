Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35002 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbbETKly (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 May 2015 06:41:54 -0400
Received: by wicmx19 with SMTP id mx19so149820417wic.0
        for <linux-wpan@vger.kernel.org>; Wed, 20 May 2015 03:41:52 -0700 (PDT)
Date: Wed, 20 May 2015 12:41:50 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH 5/8] ieee802154 6lowpan: Don't implement
 ieee802154_mlme_ops.
Message-ID: <20150520104146.GG3978@omega>
References: <cover.1432064518.git.buytenh@wantstofly.org>
 <20150519195011.GQ11014@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150519195011.GQ11014@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-wpan@vger.kernel.org

On Tue, May 19, 2015 at 10:50:11PM +0300, Lennert Buytenhek wrote:
> ieee802154_mlme_ops are implemented only by ARPHRD_IEEE802154
> devices.
> 

Yes, this patch is correct. I did that also for the removal the mib lock
which makes the callbacks for getting some mib values unnecessary. It
depends on context if we need to hold a lock or not (depends on if
wpan interface is up). See patch [0].

And the lowpan rx/tx functionality can't run when the wpan interface is
down.


Why I am waiting with this patch?

I thought about to send [1] to bluetooth/stable, but now I think more
it's not necessary to support some ioctl which should be deprecated and
I think that's whats Marcel also told me that I don't need to care about
this little warning and a missed rtnl lock.

- Alex

[0] http://www.spinics.net/lists/linux-wpan/msg01899.html
[1] http://www.spinics.net/lists/linux-wpan/msg01897.html
