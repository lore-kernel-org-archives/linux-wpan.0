Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34197 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbbEZSRh (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 26 May 2015 14:17:37 -0400
Received: by wicmc15 with SMTP id mc15so72688083wic.1
        for <linux-wpan@vger.kernel.org>; Tue, 26 May 2015 11:17:36 -0700 (PDT)
Date: Tue, 26 May 2015 20:17:34 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 bluetooth-next 2/6]
 Documentation/networking/ieee802154.txt: fix various inaccuracies.
Message-ID: <20150526181734.GB2954@omega>
References: <cover.1432535597.git.buytenh@wantstofly.org>
 <20150525123829.GK11340@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150525123829.GK11340@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-wpan@vger.kernel.org

On Mon, May 25, 2015 at 03:38:29PM +0300, Lennert Buytenhek wrote:
> * Update the linux-zigbee git:// repository URL.
> 
> * Remove the MLME section as the current kernel does not provide a
>   full 802.15.4 MLME implementation.
> 
> * The hardmac example driver 'fakehard' was removed some time ago.
> 
> * The IEEE 802.15.4 device drivers live in drivers/net/ieee802154/,
>   not in drivers/ieee802154/.
> 
> * The IEEE 802.15.4 MTU is 127 bytes, not 128 bytes.
> 
> * Some of the 6LoWPAN code lives in net/6lowpan/.
> 
> Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
> Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

Acked-by: Alexander Aring <alex.aring@gmail.com>

