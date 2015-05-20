Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37332 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903AbbETKp2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 May 2015 06:45:28 -0400
Received: by wibt6 with SMTP id t6so55105275wib.0
        for <linux-wpan@vger.kernel.org>; Wed, 20 May 2015 03:45:27 -0700 (PDT)
Date: Wed, 20 May 2015 12:45:24 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH 4/8] ieee802154: Remove 802.15.4/6LoWPAN checks for
 interface MTU.
Message-ID: <20150520104524.GI3978@omega>
References: <cover.1432064518.git.buytenh@wantstofly.org>
 <20150519195007.GP11014@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150519195007.GP11014@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-wpan@vger.kernel.org

On Tue, May 19, 2015 at 10:50:07PM +0300, Lennert Buytenhek wrote:
> In the past, 802.15.4 interfaces and 6LoWPAN interfaces used the
> same dev->type (ARPHRD_IEEE802154), and 802.15.4 interfaces were
> distinguished from 6LoWPAN interfaces by their differing dev->mtu.
> 
> 6LoWPAN interfaces have their own ARPHRD type now, so there is no
> longer any need to check dev->mtu to distinguish 802.15.4 devices
> from 6LoWPAN devices.
> 
> Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>

Acked-by: Alexander Aring <alex.aring@gmail.com>

btw: the reason why I introduced this was that I had really fear to
change the lowpan ARPHRD, because there exists already a huge of
software which support this and somebody told me that when he delete a
lowpan interface with the iz tool then the whole kernel was crashed.
This was indeed true because it had freed some resources which was
allocated on a wpan interface only.

But we don't need this anymore, yes. I changed the ARPHRD and nobody
screamed that his/her software doesn't work anymore.

- Alex
