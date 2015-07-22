Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37847 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964956AbbGVQ0q (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 22 Jul 2015 12:26:46 -0400
Received: by wibud3 with SMTP id ud3so180675691wib.0
        for <linux-wpan@vger.kernel.org>; Wed, 22 Jul 2015 09:26:44 -0700 (PDT)
Date: Wed, 22 Jul 2015 18:26:41 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next] mac802154: Fix memory corruption with
 global deferred transmit state.
Message-ID: <20150722162636.GA9538@omega>
References: <20150721144447.GH20876@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150721144447.GH20876@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-wpan@vger.kernel.org

Hi Lennert,

On Tue, Jul 21, 2015 at 05:44:47PM +0300, Lennert Buytenhek wrote:
> When transmitting a packet via a mac802154 driver that can sleep in
> its transmit function, mac802154 defers the call to the driver's
> transmit function to a per-device workqueue.
> 
> However, mac802154 uses a single global work_struct for this, which
> means that if you have more than one registered mac802154 interface
> in the system, and you transmit on more than one of them at the same
> time, you'll very easily cause memory corruption.
> 
> This patch moves the deferred transmit processing state from global
> variables to struct ieee802154_local, and this seems to fix the memory
> corruption issue.
> 
> Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>

Acked-by: Alexander Aring <alex.aring@gmail.com>

> ---
> There were patches for this issue on the mailing list, but it
> doesn't seem that a fix for this issue has been applied yet -- how
> about this?
> 

yes, something went wrong. Nevertheless I like your patch which also
improved by calling INIT_WORK once at hardware alloc, great. :-)

Thanks Lennert.

- Alex
