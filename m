Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:35243 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbbETKgL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 May 2015 06:36:11 -0400
Received: by wgfl8 with SMTP id l8so48009142wgf.2
        for <linux-wpan@vger.kernel.org>; Wed, 20 May 2015 03:36:10 -0700 (PDT)
Date: Wed, 20 May 2015 12:36:07 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH 1/8] ieee802154 socket: Return EMSGSIZE from
 raw_sendmsg() if packet too big.
Message-ID: <20150520103604.GF3978@omega>
References: <cover.1432064518.git.buytenh@wantstofly.org>
 <20150519194956.GM11014@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150519194956.GM11014@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-wpan@vger.kernel.org

On Tue, May 19, 2015 at 10:49:56PM +0300, Lennert Buytenhek wrote:
> The proper return code for trying to send a packet that exceeds the
> outgoing interface's MTU is EMSGSIZE, not EINVAL, so patch ieee802154's
> raw_sendmsg() to do the right thing.  (Its dgram_sendmsg() was already
> returning EMSGSIZE for this case.)
> 
> Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>

Nice, I never looked into the socket code deeper. But I think there are
several issues (from that what I read from the mailinglist.) I also put
it the opentasks section in wpan.cakelab.org that the socket code needs
a big rework/cleanup.

Acked-by: Alexander Aring <alex.aring@gmail.com>

- Alex
